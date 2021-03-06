#include "nw_i0_spells"
#include "inc_item_props"
#include "prc_feat_const"
#include "prc_class_const"
#include "prc_spell_const"
#include "prc_inc_clsfunc"
void main()
{
    object oPC = GetPCSpeaker();
    object oWeapon = GetItemPossessedBy(oPC, "codi_sam_mw");
    itemproperty ip;
    ip = ItemPropertyCastSpell(IP_CONST_CASTSPELL_IMPROVED_INVISIBILITY_7,IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY);
    AddItemProperty(DURATION_TYPE_PERMANENT, ip, oWeapon);
    WeaponUpgradeVisual();
}

