public with sharing class SupportPlanUpdateScheduler implements Schedulable {
    public void execute(SchedulableContext sc) {
        SupportPlanUpdateBatch batchable = new SupportPlanUpdateBatch();
        Database.executeBatch(batchable, 50);
    }
}