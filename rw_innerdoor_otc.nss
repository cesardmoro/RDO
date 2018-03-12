/************** RandomWay - inner deputy onUse event Handler  ****************
Package: RandomWay - inner deputy onUse event handler
Author: Inquisidor
*******************************************************************************/

void main() {
    ExecuteScript( "rw_ontransclick", OBJECT_SELF );
}


/*
#include "RW_facade_inc"
#include "Party_generic"
#include "Location_tools"

void main() {

    object user = GetClickingObject();
    if( user == OBJECT_INVALID )
        user = GetLastUsedBy();

    object outerDoorBody = GetLocalObject( OBJECT_SELF, RW_InnerDoor_outerDoorBody_VN );
    object target = RW_Transition_getArrivePoint( outerDoorBody );

    // if this transition is implemented with a a trap trigger and the previos traversed transition was the couple of this transition, means that this transition trigger was configured to use the onEnter or onTrapTriggered events (instead of the onTransitionClick event), and it was fired when the user arrived from the couple. So, the event must be ignored to avoid sending the user back to this transition couple..
    if(
        GetObjectType(OBJECT_SELF) != OBJECT_TYPE_TRIGGER
        || !GetIsTrapped(OBJECT_SELF)
        || GetLocalObject( user, RW_Pc_previousTransition_VN ) != outerDoorBody
    ) {
        AssignCommand( user, JumpToObject(target) );
        Party_jumpAllAssociatesToObject( user, target );

        // clears the forced location for the encounters generated by the RandomSpawn system.
        DeleteLocalObject( user, Location_PJ_punteroUbicacionForzada_VN );
    }

    SetLocalObject( user, RW_Pc_previousTransition_VN, OBJECT_SELF );
}
*/