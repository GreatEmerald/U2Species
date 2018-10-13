//-----------------------------------------------------------
// U2Pawn.uc
// A Pawn with correct sound volume settings and extended footstep sound support
// GreatEmerald, 2008 and 2009
//-----------------------------------------------------------
class U2Pawn extends xPawn;

#exec obj load file=U2SpecM20.uax
#exec obj load file=U2SpecM21.uax
#exec obj load file=U2SpecM22.uax
#exec obj load file=U2SpecM26.uax
#exec obj load file=U2SpecM30.uax
#exec obj load file=U2SpecF22.uax
#exec obj load file=U2SpecS.uax

var int SurfaceNum;
var(Sounds) Sound   SoundLands[11];
var(Sounds) Sound   SoundCorpseLands[11];
var(Sounds) class<U2MarshalSoundGroup> NewSoundGroupClass;

simulated function FootStepping(int Side)
{
    local int i;
    local actor A;
    local material FloorMat;
    local vector HL,HN,Start,End,HitLocation,HitNormal;

    SurfaceNum = 0;

    for ( i=0; i<Touching.Length; i++ )
        if ( ((PhysicsVolume(Touching[i]) != None) && PhysicsVolume(Touching[i]).bWaterVolume)
            || (FluidSurfaceInfo(Touching[i]) != None) )
        {

            PlaySound(SoundFootsteps[9], SLOT_Interact, FootstepVolume );

            if ( !Level.bDropDetail && (Level.DetailMode != DM_Low) && (Level.NetMode != NM_DedicatedServer)
                && !Touching[i].TraceThisActor(HitLocation, HitNormal,Location - CollisionHeight*vect(0,0,1.1), Location) )
                    Spawn(class'WaterRing',,,HitLocation,rot(16384,0,0));
            return;
        }

    if ( bIsCrouched || bIsWalking )
        return;

    if ( (Base!=None) && (!Base.IsA('LevelInfo')) && (Base.SurfaceType!=0) )
    {
        SurfaceNum = Base.SurfaceType;
    }
    else
    {
        Start = Location - Vect(0,0,1)*CollisionHeight;
        End = Start - Vect(0,0,16);
        A = Trace(hl,hn,End,Start,false,,FloorMat);
        if (FloorMat !=None)
            SurfaceNum = FloorMat.SurfaceType;
    }
    PlaySound(SoundFootsteps[SurfaceNum], SLOT_Interact, FootstepVolume,,400 );
}


event Landed(vector HitNormal)
{
    local int i;
    local actor A;
    local material FloorMat;
    local vector HL,HN,Start,End,HitLocation;

    SurfaceNum = 0;

    for ( i=0; i<Touching.Length; i++ )
        if ( ((PhysicsVolume(Touching[i]) != None) && PhysicsVolume(Touching[i]).bWaterVolume)
            || (FluidSurfaceInfo(Touching[i]) != None) )
        {

            PlaySound(SoundLands[9], SLOT_Interact, FootstepVolume );

            if ( !Level.bDropDetail && (Level.DetailMode != DM_Low) && (Level.NetMode != NM_DedicatedServer)
                && !Touching[i].TraceThisActor(HitLocation, HitNormal,Location - CollisionHeight*vect(0,0,1.1), Location) )
                    Spawn(class'WaterRing',,,HitLocation,rot(16384,0,0));
            return;
        }

    if ( bIsCrouched || bIsWalking )
        return;

    if ( (Base!=None) && (!Base.IsA('LevelInfo')) && (Base.SurfaceType!=0) )
    {
        SurfaceNum = Base.SurfaceType;
    }
    else
    {
        Start = Location - Vect(0,0,1)*CollisionHeight;
        End = Start - Vect(0,0,16);
        A = Trace(hl,hn,End,Start,false,,FloorMat);
        if (FloorMat !=None)
            SurfaceNum = FloorMat.SurfaceType;
    }

    super(UnrealPawn).Landed( HitNormal );
    MultiJumpRemaining = MaxMultiJump;

    if ( (Health > 0) && !bHidden && (Level.TimeSeconds - SplashTime > 0.25) )
        PlayOwnedSound(SoundLands[SurfaceNum], SLOT_Interact, FMin(1,-0.3 * Velocity.Z/JumpZ));
}

State Dying
{
    simulated function AnimEnd( int Channel )
    {
        ReduceCylinder();
    }

    event FellOutOfWorld(eKillZType KillType)
    {
        local LavaDeath LD;

        // If we fall past a lava killz while dead- burn off skin.
        if( KillType == KILLZ_Lava )
        {
            if ( !bSkeletized )
            {
                if ( SkeletonMesh != None )
                {
                    LinkMesh(SkeletonMesh, true);
                    Skins.Length = 0;
                }
                bSkeletized = true;

                LD = spawn(class'LavaDeath', , , Location + vect(0, 0, 10), Rotation );
                if ( LD != None )
                    LD.SetBase(self);
                // This should destroy itself once its finished.

                PlaySound( sound'WeaponSounds.BExplosion5', SLOT_None, 1.5*TransientSoundVolume );
            }

            return;
        }

        Super(UnrealPawn).FellOutOfWorld(KillType);
    }

    function LandThump()
    {
        // animation notify - play sound if actually landed, and animation also shows it
        if ( Physics == PHYS_None)
        {
            bThumped = true;
            PlaySound(SoundCorpseLands[SurfaceNum], SLOT_Interact, FMin(1,-0.3 * Velocity.Z/JumpZ));
        }
    }

    simulated function TakeDamage( int Damage, Pawn InstigatedBy, Vector Hitlocation, Vector Momentum, class<DamageType> damageType)
    {
        local Vector SelfToHit, SelfToInstigator, CrossPlaneNormal;
        local float W;
        local float YawDir;

        local Vector HitNormal, shotDir;
        local Vector PushLinVel, PushAngVel;
        local Name HitBone;
        local float HitBoneDist;
        local int MaxCorpseYawRate;

        if ( bFrozenBody || bRubbery )
            return;

        if( Physics == PHYS_KarmaRagdoll )
        {
            // Can't shoot corpses during de-res
            if( bDeRes || bRubbery )
                return;

            // Throw the body if its a rocket explosion or shock combo
            if( damageType.Default.bThrowRagdoll )
            {
                shotDir = Normal(Momentum);
                PushLinVel = (RagDeathVel * shotDir) +  vect(0, 0, 250);
                PushAngVel = Normal(shotDir Cross vect(0, 0, 1)) * -18000;
                KSetSkelVel( PushLinVel, PushAngVel );
            }
            else if( damageType.Default.bRagdollBullet )
            {
                if ( Momentum == vect(0,0,0) )
                    Momentum = HitLocation - InstigatedBy.Location;
                if ( FRand() < 0.65 )
                {
                    if ( Velocity.Z <= 0 )
                        PushLinVel = vect(0,0,40);
                    PushAngVel = Normal(Normal(Momentum) Cross vect(0, 0, 1)) * -8000 ;
                    PushAngVel.X *= 0.5;
                    PushAngVel.Y *= 0.5;
                    PushAngVel.Z *= 4;
                    KSetSkelVel( PushLinVel, PushAngVel );
                }
                PushLinVel = RagShootStrength*Normal(Momentum);
                KAddImpulse(PushLinVel, HitLocation);
                if ( (LifeSpan > 0) && (LifeSpan < DeResTime + 2) )
                    LifeSpan += 0.2;
            }
            else
            {
                PushLinVel = RagShootStrength*Normal(Momentum);
                KAddImpulse(PushLinVel, HitLocation);
            }
            if ( (DamageType.Default.DamageOverlayMaterial != None) && (Level.DetailMode != DM_Low) && !Level.bDropDetail )
                SetOverlayMaterial(DamageType.Default.DamageOverlayMaterial, DamageType.default.DamageOverlayTime, true);
            return;
        }

        if ( DamageType.default.bFastInstantHit && GetAnimSequence() == 'Death_Spasm' && RepeaterDeathCount < 6)
        {
            PlayAnim('Death_Spasm',, 0.2);
            RepeaterDeathCount++;
        }
        else if (Damage > 0)
        {
            if ( InstigatedBy != None )
            {
                if ( InstigatedBy.IsA('xPawn') && xPawn(InstigatedBy).bBerserk )
                    Damage *= 2;

                // Figure out which direction to spin:

                if( InstigatedBy.Location != Location )
                {
                    SelfToInstigator = InstigatedBy.Location - Location;
                    SelfToHit = HitLocation - Location;

                    CrossPlaneNormal = Normal( SelfToInstigator cross Vect(0,0,1) );
                    W = CrossPlaneNormal dot Location;

                    if( HitLocation dot CrossPlaneNormal < W )
                        YawDir = -1.0;
                    else
                        YawDir = 1.0;
                }
            }
            if( VSize(Momentum) < 10 )
            {
                Momentum = - Normal(SelfToInstigator) * Damage * 1000.0;
                Momentum.Z = Abs( Momentum.Z );
            }

            SetPhysics(PHYS_Falling);
            Momentum = Momentum / Mass;
            AddVelocity( Momentum );
            bBounce = true;

            RotationRate.Pitch = 0;
            RotationRate.Yaw += VSize(Momentum) * YawDir;

            MaxCorpseYawRate = 150000;
            RotationRate.Yaw = Clamp( RotationRate.Yaw, -MaxCorpseYawRate, MaxCorpseYawRate );
            RotationRate.Roll = 0;

            bFixedRotationDir = true;
            bRotateToDesired = false;

            Health -= Damage;
            CalcHitLoc( HitLocation, vect(0,0,0), HitBone, HitBoneDist );

            if( InstigatedBy != None )
                HitNormal = Normal( Normal(InstigatedBy.Location-HitLocation) + VRand() * 0.2 + vect(0,0,2.8) );
            else
                HitNormal = Normal( Vect(0,0,1) + VRand() * 0.2 + vect(0,0,2.8) );

            DoDamageFX( HitBone, Damage, DamageType, Rotator(HitNormal) );
        }
    }

    simulated function BeginState()
    {
        Super.BeginState();
        AmbientSound = None;
    }

    simulated function Timer()
    {
        local KarmaParamsSkel skelParams;

        if ( !PlayerCanSeeMe() )
        {
            Destroy();
        }
        // If we are running out of life, bute we still haven't come to rest, force the de-res.
        // unless pawn is the viewtarget of a player who used to own it
        else if ( LifeSpan <= DeResTime && bDeRes == false )
        {
            skelParams = KarmaParamsSkel(KParams);

            // check not viewtarget
            if ( (PlayerController(OldController) != None) && (PlayerController(OldController).ViewTarget == self)
                && (Viewport(PlayerController(OldController).Player) != None) )
            {
                skelParams.bKImportantRagdoll = true;
                LifeSpan = FMax(LifeSpan,DeResTime + 2.0);
                SetTimer(1.0, false);
                return;
            }
            else
            {
                skelParams.bKImportantRagdoll = false;
            }
            // spawn derez
            StartDeRes();
        }
        else
        {
            SetTimer(1.0, false);
        }
    }

    // We shorten the lifetime when the guys comes to rest.
    event KVelDropBelow()
    {
        local float NewLifeSpan;

        if(bDeRes == false)
        {
            //Log("Low Vel - Reducing LifeSpan!");
            NewLifeSpan = DeResTime + 3.5;
            if(NewLifeSpan < LifeSpan)
                LifeSpan = NewLifeSpan;
        }
    }
}

function TakeFallingDamage()
{
   /*local float EffectiveSpeed;
   Super.TakeFallingDamage();

   if (Velocity.Z < -1 * MaxFallSpeed)
   {
      AmbientSound = NewSoundGroupClass.static.GetFallSound();
      if ( EffectiveSpeed < (-1 * MaxFallSpeed) )
         AmbientSound = none;
   } */
    local float Shake, EffectiveSpeed;


    if (Velocity.Z < -0.5 * MaxFallSpeed)
    {
        if ( Role == ROLE_Authority )
        {
            MakeNoise(1.0);
            if (Velocity.Z < -1 * MaxFallSpeed)
            {

                EffectiveSpeed = Velocity.Z;
                if ( TouchingWaterVolume() )
                    EffectiveSpeed = FMin(0, EffectiveSpeed + 100);
                if ( EffectiveSpeed < -1 * MaxFallSpeed ){
                    TakeDamage(-100 * (EffectiveSpeed + MaxFallSpeed)/MaxFallSpeed, None, Location, vect(0,0,0), class'Fell');

                }
            }
        }
        if ( Controller != None )
        {
            Shake = FMin(1, -1 * Velocity.Z/MaxFallSpeed);
            Controller.DamageShake(Shake);

        }
    }
    else if (Velocity.Z < -1.4 * JumpZ){
        MakeNoise(0.5);
    }
}

function Timer()  //HACK and ugly!
{
  if (Velocity.Z < -1 * MaxFallSpeed){
     //if (Species == class'U2Species.SPECIES_U2Marshal') AmbientSound = sound'U2SpeciesSounds.Falling.Falling';
     //else
     if (Species == class'U2Species.SPECIES_U2Male20s') AmbientSound = sound'U2SpecM20.Falling.Falling';
     else if (Species == class'U2Species.SPECIES_U2Male21s') AmbientSound = sound'U2SpecM21.Falling.Falling';
     else if (Species == class'U2Species.SPECIES_U2Male22s') AmbientSound = sound'U2SpecM22.Falling.Falling';
     else if (Species == class'U2Species.SPECIES_U2Male26s') AmbientSound = sound'U2SpecM26.Falling.Falling';
     else if (Species == class'U2Species.SPECIES_U2Male30s') AmbientSound = sound'U2SpecM30.Falling.Falling';
     else if (Species == class'U2Species.SPECIES_U2Female22s') AmbientSound = sound'U2SpecF22.Falling.Falling';
     else if (Species == class'U2Species.SPECIES_U2Skaarj') AmbientSound = sound'U2SpecS.Falling.Falling';
     else AmbientSound = sound'U2SpeciesSounds.Falling.Falling';
     }
}

singular event BaseChange() //&&GE(note): Thanks to Wormbo for this tip.
{
   super.BaseChange();
   if (Base == none)
    SetTimer(0.5, true);
   else if (Base != none)
    SetTimer(0.0, false);

   if (((Base != none) || (TouchingWaterVolume() == true)) && (AmbientSound == sound'U2SpeciesSounds.Falling.Falling' || AmbientSound == sound'U2SpecM20.Falling.Falling' ||  //HACK, but no way around that
                    AmbientSound == sound'U2SpecM21.Falling.Falling' || AmbientSound == sound'U2SpecM22.Falling.Falling' ||
                    AmbientSound == sound'U2SpecM26.Falling.Falling' || AmbientSound == sound'U2SpecM30.Falling.Falling' ||
                    AmbientSound == sound'U2SpecF22.Falling.Falling' || AmbientSound == sound'U2SpecS.Falling.Falling' ))
                    AmbientSound = none;
}

function PlayDyingSound()
{
    // Dont play dying sound if a skeleton. Tricky without vocal chords.
    if ( bSkeletized )
        return;

    if ( bGibbed )
    {
        PlaySound(GibGroupClass.static.GibSound(), SLOT_Pain,3.5*TransientSoundVolume,true,500);
        return;
    }

    if ( HeadVolume.bWaterVolume )
    {
        PlaySound(GetSound(EST_Drown), SLOT_Pain,2.5*TransientSoundVolume,true,500);
        return;
    }

    PlaySound(SoundGroupClass.static.GetDeathSound(), SLOT_Pain,3.3*TransientSoundVolume, true,500);
}

function PlayTakeHit(vector HitLocation, int Damage, class<DamageType> DamageType)
{
    PlayDirectionalHit(HitLocation);

    if( Level.TimeSeconds - LastPainSound < MinTimeBetweenPainSounds )
        return;

    LastPainSound = Level.TimeSeconds;

    if( HeadVolume.bWaterVolume )
    {
        if( DamageType.IsA('Drowned') )
            PlaySound( GetSound(EST_Drown), SLOT_Pain,1.5*TransientSoundVolume );
        else
            PlaySound( GetSound(EST_HitUnderwater), SLOT_Pain,1.5*TransientSoundVolume );
        return;
    }

    PlaySound(SoundGroupClass.static.GetHitSound(), SLOT_Pain,2.7*TransientSoundVolume,,200);
}

DefaultProperties
{
  SoundFootsteps[0]=Sound'U2SpeciesSounds.Movement.StepRock'
  SoundFootsteps[1]=Sound'U2SpeciesSounds.Movement.StepRock'
  SoundFootsteps[2]=Sound'U2SpeciesSounds.Movement.StepDirt'
  SoundFootsteps[3]=Sound'U2SpeciesSounds.Movement.StepMetal'
  SoundFootsteps[4]=Sound'U2SpeciesSounds.Movement.StepWood'
  SoundFootsteps[5]=Sound'U2SpeciesSounds.Movement.StepLeaves'
  SoundFootsteps[6]=Sound'U2SpeciesSounds.Movement.StepSkin'
  SoundFootsteps[7]=Sound'U2SpeciesSounds.Movement.StepIce'
  SoundFootsteps[8]=Sound'U2SpeciesSounds.Movement.StepSnow'
  SoundFootsteps[9]=Sound'U2SpeciesSounds.Movement.StepWater'
  SoundFootsteps[10]=Sound'U2SpeciesSounds.Movement.StepGlass'
  SoundLands[0]=Sound'U2SpeciesSounds.Landed.Stone'
  SoundLands[1]=Sound'U2SpeciesSounds.Landed.Stone'
  SoundLands[2]=Sound'U2SpeciesSounds.Landed.Dirt'
  SoundLands[3]=Sound'U2SpeciesSounds.Landed.Metal'
  SoundLands[4]=Sound'U2SpeciesSounds.Landed.Wood'
  SoundLands[5]=Sound'U2SpeciesSounds.Landed.Grass'
  SoundLands[6]=Sound'U2SpeciesSounds.Landed.Skin'
  SoundLands[7]=Sound'U2SpeciesSounds.Landed.Ice'
  SoundLands[8]=Sound'U2SpeciesSounds.Landed.Snow'
  SoundLands[9]=Sound'U2SpeciesSounds.Landed.Water'
  SoundLands[10]=Sound'U2SpeciesSounds.Landed.Glass'
  SoundCorpseLands[0]=Sound'U2SpeciesSounds.BodyLanded.Bodyfall_Grass06'
  SoundCorpseLands[1]=Sound'U2SpeciesSounds.BodyLanded.Bodyfall_Dirt16'
  SoundCorpseLands[2]=Sound'U2SpeciesSounds.BodyLanded.Bodyfall_Dirt11'
  SoundCorpseLands[3]=Sound'U2SpeciesSounds.BodyLanded.Bodyfall_Grass02'
  SoundCorpseLands[4]=Sound'U2SpeciesSounds.BodyLanded.Bodyfall_Grass05'
  SoundCorpseLands[5]=Sound'U2SpeciesSounds.BodyLanded.Bodyfall_Grass01'
  SoundCorpseLands[6]=Sound'U2SpeciesSounds.BodyLanded.Bodyfall_Dirt15'
  SoundCorpseLands[7]=Sound'U2SpeciesSounds.BodyLanded.Bodyfall_Dirt15'
  SoundCorpseLands[8]=Sound'U2SpeciesSounds.BodyLanded.Bodyfall_Dirt15'
  SoundCorpseLands[9]=Sound'U2SpeciesSounds.BodyLanded.Bodyfall_Water'
  SoundCorpseLands[10]=Sound'U2SpeciesSounds.BodyLanded.Bodyfall_Grass02'
  FootstepVolume=0.5
  GruntVolume=1.34
  GibGroupClass=class'U2GibGroup'
  RagImpactSounds(0)=sound'U2SpeciesSounds.BodyLanded.BodyFalls1'
  RagImpactSounds(1)=sound'U2SpeciesSounds.BodyLanded.BodyFalls2'
  RagImpactSounds(2)=sound'U2SpeciesSounds.BodyLanded.BodyFalls3'
  SoundVolume=255
  SoundRadius=300
  NewSoundGroupClass=class'U2MarshalSoundGroup'
}
