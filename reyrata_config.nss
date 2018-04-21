int iLifes = 4; // Son las vidas que tiene el bicho, si al morir revive cuantas veces.



void main() 
{

	SetImmortal(OBJECT_SELF,1);
	SetLocalInt( OBJECT_SELF, "iLifes", iLifes);
	SetLocalInt( OBJECT_SELF, "iDeaths", 0); 
	SetLocalInt( OBJECT_SELF, "busy", 0); //DEFINE SI ESTA OCUPADO LANZANDO SKILL SE UTILIZA PARA EVITAR ACCIONES EN SIMULTANEO
} 


