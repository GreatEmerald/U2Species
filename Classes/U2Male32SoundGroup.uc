//==============================================================================
// U2Male32SoundGroup.uc
// TCA Marshal, although not official.
// 2009, GreatEmerald
//==============================================================================

class U2Male32SoundGroup extends U2MarshalSoundGroup;

defaultproperties
{
    Sounds(2)=Sound'U2SpecM32.HitSoft.HitSofts'
    Sounds(4)=Sound'U2SpecM32.HitSoft.HitSofts'

    PainSounds(0)=Sound'U2SpecM32.HitHard.HitHards'
    PainSounds(1)=Sound'U2SpecM32.HitHard.HitHards'
    PainSounds(2)=Sound'U2SpecM32.HitHard.HitHards'
    PainSounds(3)=Sound'U2SpecM32.HitSoft.HitSofts'
    PainSounds(4)=Sound'U2SpecM32.HitSoft.HitSofts'
    PainSounds(5)=Sound'U2SpecM32.HitSoft.HitSofts'

    DeathSounds(0)=Sound'U2SpecM32.DieSoft.DieSofts'
    DeathSounds(1)=Sound'U2SpecM32.DieSoft.DieSofts'
    DeathSounds(2)=Sound'U2SpecM32.DieSoft.DieSofts'
    DeathSounds(3)=Sound'U2SpecM32.DieHard.DieHards'
    DeathSounds(4)=Sound'U2SpecM32.DieHard.DieHards'
}
