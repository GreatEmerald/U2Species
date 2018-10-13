//==============================================================================
// U2Male20SoundGroup.uc
// Generic marine.
// 2008, GreatEmerald
//==============================================================================

class U2Male20SoundGroup extends U2MarshalSoundGroup;

defaultproperties
{
    //Sounds(0)=Sound'U2SpecM20.LandHard.Lands'
    Sounds(2)=Sound'U2SpecM20.HitSoft.HitSofts'
    Sounds(4)=Sound'U2SpecM20.HitSoft.HitSofts'

    PainSounds(0)=Sound'U2SpecM20.HitHard.HitHards'
    PainSounds(1)=Sound'U2SpecM20.HitHard.HitHards'
    PainSounds(2)=Sound'U2SpecM20.HitHard.HitHards'
    PainSounds(3)=Sound'U2SpecM20.HitSoft.HitSofts'
    PainSounds(4)=Sound'U2SpecM20.HitSoft.HitSofts'
    PainSounds(5)=Sound'U2SpecM20.HitSoft.HitSofts'

    DeathSounds(0)=Sound'U2SpecM20.DieSoft.TakeDamage_01_004c'
    DeathSounds(1)=Sound'U2SpecM20.DieSoft.TakeDamage_01_005c'
    DeathSounds(2)=Sound'U2SpecM20.DieHard.TakeDamage_01_006c'
    DeathSounds(3)=Sound'U2SpecM20.DieHard.TakeDamage_01_008c'
    DeathSounds(4)=Sound'U2SpecM20.DieHard.TakeDamage_01_008b'
    FallSound(0)=sound'U2SpecM20.Falling.Falling'
}
