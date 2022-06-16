public with sharing class SupportPlanUpdateBatch implements Database.Batchable<sObject>, Database.Stateful {
    private Integer recordsProcessed = 0;

    public Database.QueryLocator start(Database.BatchableContext bc) {
        //get target records
        String query = 'SELECT Id, Support_Plan__c, Account.CustomerPriority__c '
            + 'FROM Case '
            + 'WHERE Support_Plan__c = null '
            + 'AND Account.CustomerPriority__c != null';
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext bc, List<Case> cases) {
        //business processing logic
        for(Case cs : cases) {
            if(cs.Account.CustomerPriority__c == 'High') {
                cs.Support_Plan__c = 'Premium';
            } else if(cs.Account.CustomerPriority__c == 'Medium') {
                cs.Support_Plan__c = 'Standard';
            } else {
                cs.Support_Plan__c = 'Basic';
            }
            recordsProcessed++;
        }
        update cases;
    }

    public void finish(Database.BatchableContext bc) {
        //post processing logic
        Application_Log__c log = new Application_Log__c();
        log.Status__c = 'Success';
        log.Target_Type__c = 'Batch';
        log.Target_Name__c = 'SupportPlanUpdateBatch';
        log.Message__c = recordsProcessed + ' records have been updated with their right support plan.';
        insert log;
    }
}