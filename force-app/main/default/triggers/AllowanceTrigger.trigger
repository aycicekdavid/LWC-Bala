trigger AllowanceTrigger on Allowance__c (before insert, before update) {
    if(Trigger.isBefore) {
        if(Trigger.isInsert) {
            AllowanceTriggerHandler.beforeInsert(Trigger.new);
        }
        if(Trigger.isUpdate) {
            AllowanceTriggerHandler.beforeUpdate(Trigger.newMap, Trigger.oldMap);
        }
    }
}