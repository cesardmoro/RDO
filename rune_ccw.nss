/*
// As cure light wounds, except cure critical wounds
// cures 4d8 points of damage plus 1 point per
// caster level (up to +20).
*/

#include "prc_class_const"

void main()
{
      object oPC = OBJECT_SELF;
      int nLevel = GetLevelByClass(CLASS_TYPE_RUNESCARRED,oPC);

      effect eCure = EffectHeal(d8(4) + nLevel);

      effect eVis = EffectVisualEffect(VFX_IMP_HEALING_G);

      effect eLink = EffectLinkEffects(eCure,eVis);

      ApplyEffectToObject(DURATION_TYPE_INSTANT,eLink,oPC);
}