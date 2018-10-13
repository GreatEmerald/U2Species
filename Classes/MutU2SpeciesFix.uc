//==============================================================================
// MutU2SpeciesFix.uc
// This only fixes THESE species as there is no other way.
// 2008, GreatEmerald
//==============================================================================

class MutU2SpeciesFix extends Mutator;

#exec obj load file=U2SpeciesSounds.uax

var array<string> SpeciesClasses;

function ModifyPlayer(Pawn Other)
{
  local class<SpeciesType> stClass;
  local int i;
  local Controller C;

  for (i = 0; i < SpeciesClasses.length; i++){

  stClass = class<SpeciesType>(DynamicLoadObject(SpeciesClasses[i], class'Class'));

  if (xPawn(Other) != none) {

    if (xPawn(Other).Species == stClass){
       C = Other.Controller;
       C.PawnClass = class'U2Pawn';

    }
  }
  Super.ModifyPlayer(Other);
  }
}

defaultproperties
{
  FriendlyName = "Unreal II Species fix"
  Description  = "Fixes the silent sound issue of Unreal II species. Mostly compatible with other mutators and custom gametypes. NOT COMPATIBLE with Slave Master gametype."
  SpeciesClasses(0)="U2Species.SPECIES_U2Marshal"
  SpeciesClasses(1)="U2Species.SPECIES_U2Male20s"
  SpeciesClasses(2)="U2Species.SPECIES_U2Male21s"
  SpeciesClasses(3)="U2Species.SPECIES_U2Male22s"
  SpeciesClasses(4)="U2Species.SPECIES_U2Male26s"
  SpeciesClasses(5)="U2Species.SPECIES_U2Male30s"
  SpeciesClasses(6)="U2Species.SPECIES_U2Male32s"
  SpeciesClasses(7)="U2Species.SPECIES_U2Female22s"
  SpeciesClasses(8)="U2Species.SPECIES_U2Skaarj"
  SpeciesClasses(9)="U2Species.SPECIES_U2Male23s"
  SpeciesClasses(10)="U2Species.SPECIES_U2Male27s"
  SpeciesClasses(11)="U2Species.SPECIES_U2Male28s"
  SpeciesClasses(12)="U2Species.SPECIES_U2Female20s"
  SpeciesClasses(13)="U2Species.SPECIES_U2Female21s"
  SpeciesClasses(14)="U2Species.SPECIES_U2Female23s"
  SpeciesClasses(15)="U2Species.SPECIES_U2Meyer"
}
