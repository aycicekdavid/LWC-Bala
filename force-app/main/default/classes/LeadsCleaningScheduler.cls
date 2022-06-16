public with sharing class LeadsCleaningScheduler implements Schedulable {
    public void execute(SchedulableContext sc) {
        LeadsCleaningBatch batchable = new LeadsCleaningBatch();
        Database.executeBatch(batchable, 50);
    }
}