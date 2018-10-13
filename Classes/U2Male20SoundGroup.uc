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

    DeathSounds(0)=SoundGroup'U2SpecM20.DieHard.DieHards'
    DeathSounds(1)=SoundGroup'U2SpecM20.DieSoft.DieSofts'
    DeathSounds(2)=SoundGroup'U2SpecM20.DieHard.DieHards'
    DeathSounds(3)=SoundGroup'U2SpecM20.DieSoft.DieSofts'
    DeathSounds(4)=SoundGroup'U2SpecM20.DieHards.DieHards'
    FallSound(0)=sound'U2SpecM20.Falling.Falling'
}
