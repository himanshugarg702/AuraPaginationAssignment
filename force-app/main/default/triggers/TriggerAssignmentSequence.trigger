trigger TriggerAssignmentSequence on Contact (before insert,before update,after delete,after undelete) {
    if(Trigger.isBefore && Trigger.isInsert){
        TriggerAssignmentSequenceNumber.handleBeforeInsert(Trigger.new);
    }
    //   if(Trigger.isAfter && Trigger.isInsert){
    //     MainAssign2.handleAfterInsert(Trigger.new,Trigger.newMap);
    // }
    if(TriggerAssignmentSequenceNumber.runOnce){
                // MainAssign2.runOnce=false;
        if(Trigger.isBefore && Trigger.isUpdate){
            TriggerAssignmentSequenceNumber.handleBeforeUpdate(Trigger.newMap,Trigger.oldMap);
            // TriggerHandler.runOnce = false;
        }
    }
    
    if(Trigger.isAfter && Trigger.isDelete){
        TriggerAssignmentSequenceNumber.handleAfterDelete(Trigger.old);
    }
    if(Trigger.isAfter && Trigger.isUndelete){
        TriggerAssignmentSequenceNumber.handleAfterUndelete(Trigger.new);
    }
}