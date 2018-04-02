#include "dmfi_voice_inc"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    return (!GetIsObjectValid(GetItemPossessedBy(oPC, "hlslang_14")) &&
             GetLocalInt(oPC, Idiomas_CANTIDAD_LENGUAJES_PARA_APRENDER_POR_SKILL) > 0
            );
}
