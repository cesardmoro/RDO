//::///////////////////////////////////////////////
//:: Eagles Splendor
//:: NW_S0_EagleSpl
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Raises targets Chr by 1d4+1
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Aug 15, 2001
//:://////////////////////////////////////////////

//:: modified by mr_bumpkin Dec 4, 2003
//#include "spinc_common"

//#include "x2_inc_spellhook"
#include "spinc_common"
#include "spinc_massbuff"

void main()
{
DeleteLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR");
SetLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR", SPELL_SCHOOL_TRANSMUTATION);
/*
  Spellcast Hook Code
  Added 2003-06-23 by GeorgZ
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eRaise;
    effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

    int nMetaMagic = GetMetaMagicFeat();
    int nRaise = d4(1) + 1;
    int CasterLvl = PRCGetCasterLevel(OBJECT_SELF);
    int nDuration = CasterLvl;
    //Fire cast spell at event for the specified target
        //SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_EAGLES_SPLENDOR));

    //Enter Metamagic conditions
    if (CheckMetaMagic(nMetaMagic, METAMAGIC_MAXIMIZE))
    {
        nRaise = 5;//Damage is at max
    }
    else if (CheckMetaMagic(nMetaMagic, METAMAGIC_EMPOWER))
    {
        nRaise = nRaise + (nRaise/2); //Damage/Healing is +50%
    }
    else if (CheckMetaMagic(nMetaMagic, METAMAGIC_EXTEND))
    {
        nDuration = nDuration *2; //Duration is +100%
    }
    //Set Adjust Ability Score effect
    eRaise = EffectAbilityIncrease(ABILITY_CHARISMA, nRaise);
    effect eLink = EffectLinkEffects(eRaise, eDur);

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_EAGLE_SPLEDOR, FALSE));
    
	// bleedingedge - Strip old spell off to deal with mass buffs.
	StripBuff(oTarget, SPELL_EAGLE_SPLEDOR, SPELL_MASS_EAGLES_SPLENDOR);
	
    //Apply the VFX impact and effects
    SPApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, HoursToSeconds(nDuration),TRUE,-1,CasterLvl);
    SPApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);


DeleteLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR");
// Getting rid of the local integer storing the spellschool name

}
