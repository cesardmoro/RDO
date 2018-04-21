void buffUp()
{

  int iLifes = GetLocalInt(OBJECT_SELF, "iLifes");
  int iDeaths = GetLocalInt(OBJECT_SELF, "iDeaths");

  SetLocalInt(OBJECT_SELF,"iDeaths", (iDeaths+1));
  SetBaseAttackBonus((iDeaths*3)+8, OBJECT_SELF);
  ApplyEffectToObject(DURATION_TYPE_PERMANENT, ExtraordinaryEffect(EffectAttackIncrease(1*iDeaths)), OBJECT_SELF, 100.0f);
  ApplyEffectToObject(DURATION_TYPE_PERMANENT, ExtraordinaryEffect(EffectDamageIncrease(3*iDeaths, DAMAGE_TYPE_PIERCING)), OBJECT_SELF, 100.0f);
  int nHealed = GetMaxHitPoints(OBJECT_SELF);
  //effect eRaise = EffectResurrection();
  effect eHeal = EffectHeal(nHealed);
  //DelayCommand(0.2, ApplyEffectToObject(DURATION_TYPE_INSTANT, eRaise, OBJECT_SELF));
   ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, OBJECT_SELF);
}

void main()
{
   int iLifes = GetLocalInt(OBJECT_SELF, "iLifes");
  int iDeaths = GetLocalInt(OBJECT_SELF, "iDeaths");

  if(iDeaths<iLifes){
    if(GetCurrentHitPoints(OBJECT_SELF) == 1){
        buffUp();
    }
  }else{
    SetImmortal(OBJECT_SELF,0);
  }
}

