//==============================================================================
// U2MarshalSoundGroup.uc
// John Dalton!
// 2008, GreatEmerald
//==============================================================================

class U2MarshalSoundGroup extends xEgyptMaleSoundGroup;

var() array<sound> FallSound;

static function Sound GetFallSound()
{
    return default.FallSound[rand(default.FallSound.length)];
}

defaultproperties
{
    //Sounds(0)=Sound'U2SpeciesSounds.Jump.Landed'
    Sounds(2)=Sound'U2SpeciesSounds.HitSoft.Marshal_01_002e'
    Sounds(3)=Sound'U2SpeciesSounds.Jump.Jumps'
    Sounds(4)=Sound'U2SpeciesSounds.HitSoft.Marshal_01_003j'
    Sounds(5)=None
    Sounds(6)=None
    Sounds(7)=None
    Sounds(8)=Sound'U2SpeciesSounds.Jump.Jumps'
    Sounds(9)=Sound'U2SpeciesSounds.Jump.Jumps'

    PainSounds(0)=Sound'U2SpeciesSounds.HitSoft.HitSofts1'
    PainSounds(1)=Sound'U2SpeciesSounds.HitSoft.HitSofts2'
    PainSounds(2)=Sound'U2SpeciesSounds.HitSoft.HitSofts3'
    PainSounds(3)=Sound'U2SpeciesSounds.HitHard.HitHards'
    PainSounds(4)=Sound'U2SpeciesSounds.HitHard.HitHards2'
    PainSounds(5)=Sound'U2SpeciesSounds.HitHard.HitHards3'

    DeathSounds(0)=Sound'U2SpeciesSounds.DieSoft.Marshal_01_005c'
    DeathSounds(1)=Sound'U2SpeciesSounds.DieSoft.Marshal_01_008i'
    DeathSounds(2)=Sound'U2SpeciesSounds.DieSoft.Marshal_01_008n'
    DeathSounds(3)=Sound'U2SpeciesSounds.DieHard.DieHards1'
    DeathSounds(4)=Sound'U2SpeciesSounds.DieHard.Marshal_01_008m'
    FallSound(0)=sound'U2SpeciesSounds.Falling.Falling'
}
