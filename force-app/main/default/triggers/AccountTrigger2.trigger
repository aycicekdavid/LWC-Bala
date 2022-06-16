trigger AccountTrigger2 on Account (after update) {

    if(Trigger.isAfter) {
        if(Trigger.isUpdate) {
            AccountTriggerHandler2.afterUpdate(Trigger.newMap, Trigger.oldMap);
        }
    }
}