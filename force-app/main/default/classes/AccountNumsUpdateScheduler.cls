public with sharing class AccountNumsUpdateScheduler implements Schedulable {
    public void execute(SchedulableContext sc) {
        AccountNumsUpdateBatch accountBatch = new AccountNumsUpdateBatch();
        Database.executeBatch(accountBatch,50);
    }
}