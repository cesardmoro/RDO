#include "sp_resu_inc"

const string CURRENT_SLOT = "3";

int StartingConditional()
{
    return GetIsObjectValid( GetLocalObject(GetPCSpeaker(), TrueResurrection_deadPlayerSlot_VN_PREFIX+CURRENT_SLOT) );
}
