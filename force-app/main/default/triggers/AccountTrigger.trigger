trigger AccountTrigger on Account (before insert, after insert, before update, after update, 
before delete, after delete, after undelete) {
    //code that gets invoked
    if(Trigger.isBefore) {
        if(Trigger.isInsert) {
            //code gets executed for before insert events only            
            AccountTriggerHandler.beforeInsert(Trigger.new);
        } else if(Trigger.isUpdate) {
            //code gets executed for before update events only
            AccountTriggerHandler.beforeUpdate(Trigger.new);
        } else if(Trigger.isDelete) {
            //code gets executed for before delete events only
        }
    }
    if(Trigger.isAfter) {
        if(Trigger.isInsert) {
            //code gets executed for after insert events only
        } else if(Trigger.isUpdate) {
            //code gets executed for after update events only
        } else if(Trigger.isDelete) {
            //code gets executed for after delete events only
        } else if(Trigger.isUndelete) {
            //code gets executed for after undelete events only
        }
    }
}