//==============================================================================
// U2Male21SoundGroup.uc
// Generic marine.
// 2008, GreatEmerald
//==============================================================================

class U2Male21SoundGroup extends U2MarshalSoundGroup;

defaultproperties
{
    Sounds(2)=Sound'U2SpecM21.HitSoft.HitSofts'
    Sounds(4)=Sound'U2SpecM21.HitSoft.HitSofts'

    PainSounds(0)=Sound'U2SpecM21.HitHard.HitHards'
    PainSounds(1)=Sound'U2SpecM21.HitHard.HitHards'
    PainSounds(2)=Sound'U2SpecM21.HitHard.HitHards'
    PainSounds(3)=Sound'U2SpecM21.HitSoft.HitSofts'
    PainSounds(4)=Sound'U2SpecM21.HitSoft.HitSofts'
    PainSounds(5)=Sound'U2SpecM21.HitSoft.HitSofts'

    DeathSounds(0)=Sound'U2SpecM21.DieSoft.DieSofts'
    DeathSounds(1)=Sound'U2SpecM21.DieSoft.DieSofts'
    DeathSounds(2)=Sound'U2SpecM21.DieSoft.DieSofts'
    DeathSounds(3)=Sound'U2SpecM21.DieHard.DieHards'
    DeathSounds(4)=Sound'U2SpecM21.DieHard.DieHards'
    FallSound(0)=sound'U2SpecM21.Falling.Falling'
}
