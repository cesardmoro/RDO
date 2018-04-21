void curseDamage(effect eDam, location oLoc)
{
  object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 6.0, oLoc);
  while(oTarget != OBJECT_INVALID)
  {

    if(oTarget !=OBJECT_SELF && GetTag(oTarget) != "cria_reyrata"){ 
      if(GetDistanceBetweenLocations(oLoc, GetLocation(oTarget)) <= 6.0)
      { 
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
      }
    }
      oTarget = GetNextObjectInShape(SHAPE_SPHERE, 6.0, oLoc);
  }
} 

void explodeCurse(int iDeaths){
   location ll = GetLocation(OBJECT_SELF);
   ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_COM_CHUNK_GREEN_MEDIUM), OBJECT_SELF, 1.0f);
   ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_FNF_LOS_EVIL_30), OBJECT_SELF, 1.0f);
   //ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_FNF_HORRID_WILTING), OBJECT_SELF, 1.0f);
   SetLocalInt( OBJECT_SELF, "skillLaunched", 0 );
   effect dmg = EffectDamage(20+(iDeaths*4), DAMAGE_TYPE_ACID, DAMAGE_POWER_NORMAL);
   curseDamage(dmg, ll);
}
void curseArea(int iDeaths){
    location ll = GetLocation(OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_DUR_AURA_GREEN), OBJECT_SELF, 5.0f);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_DUR_LIGHT_GREY_15), OBJECT_SELF, 5.0f);
    float curseTime = 5.0-iDeaths;
    DelayCommand( curseTime-2,  ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_COM_BLOOD_CRT_GREEN ), OBJECT_SELF, 0.5) );
    DelayCommand( curseTime-1.5,  ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_COM_BLOOD_LRG_GREEN), OBJECT_SELF, 0.5) );
    DelayCommand( curseTime-1,  ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_COM_BLOOD_LRG_GREEN), OBJECT_SELF, 0.5) );
    DelayCommand( curseTime,  explodeCurse(iDeaths) ); 
}

void spawnRats(int iDeaths){
  ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_EVIL_HELP), OBJECT_SELF, 5.0f);
  vector vActual = GetPosition(OBJECT_SELF);
  CreateObject(OBJECT_TYPE_CREATURE,"nw_rat001",Location(GetArea(OBJECT_SELF), Vector(vActual.x+2, vActual.y+2, vActual.z), 0.0), 1, "cria_reyrata" );
  if(iDeaths >= 1)
    CreateObject(OBJECT_TYPE_CREATURE,"nw_rat001",Location(GetArea(OBJECT_SELF), Vector(vActual.x+2, vActual.y-2, vActual.z), 0.0), 1, "cria_reyrata" );
  if(iDeaths >= 2)
    CreateObject(OBJECT_TYPE_CREATURE,"nw_rat001",Location(GetArea(OBJECT_SELF), Vector(vActual.x-2, vActual.y+2, vActual.z), 0.0), 1, "cria_reyrata" );
  if(iDeaths >= 3) 
    CreateObject(OBJECT_TYPE_CREATURE,"nw_rat001",Location(GetArea(OBJECT_SELF), Vector(vActual.x-2, vActual.y-2, vActual.z), 0.0), 1, "cria_reyrata" );
}

void hide() 
{
  location ll = GetLocation(OBJECT_SELF);
  ActionDoCommand(ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT,0.5));
  SetLocalInt(OBJECT_SELF, "timer", 0);
  ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDisappearAppear(ll), OBJECT_SELF, 3.5);
} 

void endSkill(){ 
  SetLocalInt(OBJECT_SELF, "busy", 0); 
}

void main()
{ 

  location ll = GetLocation(OBJECT_SELF);
  int iDeaths = GetLocalInt(OBJECT_SELF, "iDeaths");

  if(!GetLocalInt(OBJECT_SELF, "busy" )){
      //dependiendo en que muerte este agrego nuevos skills

      int rSkill = Random(2+iDeaths); 
      SendMessageToAllDMs("skill random" + IntToString(rSkill)); 
      int busy = 0;
      switch(rSkill)
      {
        case 0:
          //DO NOTHING
          break; 
        case 1:
          //area dmg
          curseArea(iDeaths);
          busy = 1;
          break;
        case 2:
          //spawnea
          spawnRats(iDeaths);
          busy = 1;
          break;
        case 3:
          //combinados
          hide();
          spawnRats(iDeaths);
          busy = 1; 
          break;
        case 4:
          //area dmg
          curseArea(iDeaths);
          busy = 1;
          break;
      }  
      SetLocalInt(OBJECT_SELF, "busy", busy);   
      //si tiro un skill, bloqueo x 6 segundos menos la acntidad de vidas. 
      if(busy) DelayCommand( 6.0-iDeaths,  endSkill() );
  }


}


