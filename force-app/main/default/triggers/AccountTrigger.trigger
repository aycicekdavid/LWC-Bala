trigger AccountTrigger on Account (before insert, after insert, before update, after update, 
before delete, after delete, after undelete) {
    //code that gets invoked
    if(Trigger.isBefore) {
        if(Trigger.isInsert) {
            //code gets executed for before insert events only            
            AccountTriggerHandler.beforeInsert(Trigger.new);
        } else if(Trigger.isUpdate) {
            //code gets executed for before update events only
            AccountTriggerHandler.beforeUpdate(Trigger.newMap, Trigger.oldMap);
        } else if(Trigger.isDelete) {
            //code gets executed for before delete events only
            AccountTriggerHandler.beforeDelete(Trigger.oldMap);
        }
    }
    if(Trigger.isAfter) {
        if(Trigger.isInsert) {
            //code gets executed for after insert events only
            AccountTriggerHandler.afterInsert(Trigger.newMap);
        } else if(Trigger.isUpdate) {
            //code gets executed for after update events only
            AccountTriggerHandler.afterUpdate(Trigger.newMap, Trigger.oldMap);
        } else if(Trigger.isDelete) {
            //code gets executed for after delete events only
            AccountTriggerHandler.afterDelete(Trigger.oldMap);
        } else if(Trigger.isUndelete) {
            //code gets executed for after undelete events only
            AccountTriggerHandler.afterUndelete(Trigger.newMap);
        }
    }
}