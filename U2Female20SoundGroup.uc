//==============================================================================
// U2Female20SoundGroup.uc
// Liandri Angel.
// 2018, HellDragon
//==============================================================================

class U2Female20SoundGroup extends xMercFemaleSoundGroup;

var() array<sound> FallSound;

static function Sound GetFallSound()
{
    return default.FallSound[rand(default.FallSound.length)];
}

defaultproperties
{
     FallSound(0)=Sound'U2SpecF20.Falling.Falling'
     Sounds(2)=SoundGroup'U2SpecF20.HitSoft.HitSofts'
     Sounds(3)=Sound'U2SpecF20.Jumps.FemaleJump1'
     Sounds(4)=SoundGroup'U2SpecF20.HitSoft.HitSofts'
     Sounds(5)=None
     Sounds(6)=None
     Sounds(7)=None
     Sounds(8)=Sound'U2SpecF20.Jumps.FemaleDodge'
     Sounds(9)=Sound'U2SpecF20.Jumps.FemaleJump3'
     DeathSounds(0)=SoundGroup'U2SpecF20.DieSoft.DieSofts'
     DeathSounds(1)=SoundGroup'U2SpecF20.DieSoft.DieSofts'
     DeathSounds(2)=SoundGroup'U2SpecF20.DieSoft.DieSofts'
     DeathSounds(3)=SoundGroup'U2SpecF20.DieHard.DieHards'
     DeathSounds(4)=SoundGroup'U2SpecF20.DieHard.DieHards'
     PainSounds(0)=SoundGroup'U2SpecF20.HitHard.HitHards'
     PainSounds(1)=SoundGroup'U2SpecF20.HitHard.HitHards'
     PainSounds(2)=SoundGroup'U2SpecF20.HitHard.HitHards'
     PainSounds(3)=SoundGroup'U2SpecF20.HitSoft.HitSofts'
     PainSounds(4)=SoundGroup'U2SpecF20.HitSoft.HitSofts'
     PainSounds(5)=SoundGroup'U2SpecF20.HitSoft.HitSofts'
}
