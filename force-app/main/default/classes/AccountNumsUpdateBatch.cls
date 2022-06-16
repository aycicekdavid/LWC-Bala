public with sharing class AccountNumsUpdateBatch implements Database.Batchable<sObject>, Database.Stateful {

    private Integer recordsProcessed = 0;

    public Database.QueryLocator start(Database.BatchableContext bc) {
        //identify the target data
        String query = 'SELECT Id, AccountNumber FROM Account WHERE AccountNumber = null';
        return Database.getQueryLocator(query); //205
    }
    public void execute(Database.BatchableContext bc, List<Account> records) {//[1,100], [101,200], [201,205]
        //processing logic
        for(Account acc : records) {
            acc.AccountNumber = 'ACC123456';
            recordsProcessed++;
        }
        update records;
    }
    public void finish(Database.BatchableContext bc) {
        //post processing logic
        //prepare email having recordsProcessed
    }
}

/*
With Stateful       Without Stateful
205                 5
*/