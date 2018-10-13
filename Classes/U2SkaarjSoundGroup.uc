//==============================================================================
// U2SkaarjSoundGroup.uc
// The Skaarj!
// 2008, GreatEmerald
//==============================================================================

class U2SkaarjSoundGroup extends xAlienMaleSoundGroup;

var() array<sound> FallSound;

static function Sound GetFallSound()
{
    return default.FallSound[rand(default.FallSound.length)];
}

defaultproperties
{
    Sounds(2)=Sound'U2SpecS.HitHard.HitHards'
    Sounds(3)=Sound'U2SpecS.Jump.Jump1'
    Sounds(4)=Sound'U2SpecS.HitHard.HitHards'
    Sounds(5)=None
    Sounds(6)=None
    Sounds(7)=None
    Sounds(8)=Sound'U2SpecS.Jump.Dodges'
    Sounds(9)=Sound'U2SpecS.Jump.Jump2'

    PainSounds(0)=Sound'U2SpecS.HitHard.HitHards'
    PainSounds(1)=Sound'U2SpecS.HitHard.HitHards'
    PainSounds(2)=Sound'U2SpecS.HitHard.HitHards'
    PainSounds(3)=Sound'U2SpecS.HitHard.HitHards'
    PainSounds(4)=Sound'U2SpecS.HitHard.HitHards'
    PainSounds(5)=Sound'U2SpecS.HitHard.HitHards'

    DeathSounds(0)=Sound'U2SpecS.HitHard.HitHards'
    DeathSounds(1)=Sound'U2SpecS.HitHard.HitHards'
    DeathSounds(2)=Sound'U2SpecS.HitHard.HitHards'
    DeathSounds(3)=Sound'U2SpecS.HitHard.HitHards'
    DeathSounds(4)=Sound'U2SpecS.HitHard.HitHards'
    FallSound(0)=sound'U2SpecS.Falling.Falling'
}
