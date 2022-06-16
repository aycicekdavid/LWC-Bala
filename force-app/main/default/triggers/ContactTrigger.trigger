trigger ContactTrigger on Contact (after insert) {

    if(Trigger.IsAfter) {
        if(Trigger.isInsert) {
            ContactTriggerHandler.afterInsert(Trigger.newMap);
        }
    }
}