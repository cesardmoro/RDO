const int SPELL_LEVEL = 8;

void main()
{
    SetLocalInt(GetPCSpeaker(), "SPELL_LEVEL", SPELL_LEVEL);
    SetCustomToken(14001, IntToString(SPELL_LEVEL));
}
