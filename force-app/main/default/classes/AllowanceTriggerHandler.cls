public with sharing class AllowanceTriggerHandler {

    public static void beforeInsert(List<Allowance__c> newAllowances) {
        //iterate over the allowances
        checkAllowanceThresholds(newAllowances);
    }

    public static void beforeUpdate(Map<Id, Allowance__c> newAllowances, Map<Id, Allowance__c> oldAllowances) {
        List<Allowance__c> allowancesToCheck = new List<Allowance__c>();
        //iterate over the allowances
        for(Allowance__c newAl : newAllowances.values()) {
            Allowance__c oldAl = oldAllowances.get(newAl.Id);
            //check if the amount is changed and 
            if(newAl.Amount__c != oldAl.Amount__c) {
                allowancesToCheck.add(newAl);
            }
        }
        checkAllowanceThresholds(allowancesToCheck);
    }

    private static void checkAllowanceThresholds(List<Allowance__c> allowances) {
        for(Allowance__c al : allowances) {
            //check if the amount is greater than the threshold for the given allowance type
            Decimal threshold = CustomMetadataHelper.getThreshold(al.Allowance_Type__c);
            if(al.Amount__c > threshold) {
                al.addError(Label.Allowance_Threshold_Error + threshold);
            }
        }
    }

}