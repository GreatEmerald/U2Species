//==============================================================================
// U2Female22SoundGroup.uc
// Liandri Angel.
// 2009, GreatEmerald
//==============================================================================

class U2Female22SoundGroup extends xMercFemaleSoundGroup;

var() array<sound> FallSound;

static function Sound GetFallSound()
{
    return default.FallSound[rand(default.FallSound.length)];
}

defaultproperties
{
    Sounds(2)=Sound'U2SpecF22.HitSoft.HitSofts'
    Sounds(3)=Sound'U2SpecF22.Jumps.FemaleJump1'
    Sounds(4)=Sound'U2SpecF22.HitSoft.HitSofts'
    Sounds(5)=None
    Sounds(6)=None
    Sounds(7)=None
    Sounds(8)=Sound'U2SpecF22.Jumps.FemaleDodge'
    Sounds(9)=Sound'U2SpecF22.Jumps.FemaleJump3'


    PainSounds(0)=Sound'U2SpecF22.HitHard.HitHards'
    PainSounds(1)=Sound'U2SpecF22.HitHard.HitHards'
    PainSounds(2)=Sound'U2SpecF22.HitHard.HitHards'
    PainSounds(3)=Sound'U2SpecF22.HitSoft.HitSofts'
    PainSounds(4)=Sound'U2SpecF22.HitSoft.HitSofts'
    PainSounds(5)=Sound'U2SpecF22.HitSoft.HitSofts'

    DeathSounds(0)=Sound'U2SpecF22.DieSoft.DieSofts'
    DeathSounds(1)=Sound'U2SpecF22.DieSoft.DieSofts'
    DeathSounds(2)=Sound'U2SpecF22.DieSoft.DieSofts'
    DeathSounds(3)=Sound'U2SpecF22.DieHard.DieHards'
    DeathSounds(4)=Sound'U2SpecF22.DieHard.DieHards'
    FallSound(0)=sound'U2SpecF22.Falling.Falling'
}
