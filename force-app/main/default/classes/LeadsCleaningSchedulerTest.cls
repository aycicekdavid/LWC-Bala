@isTest
public class LeadsCleaningSchedulerTest {

    @TestSetup
    private static void testSetup() {
        List<Lead> leads = new List<Lead>();
        leads.addAll(TestSuite.createEmailnoPhone(3));
       	leads.addAll(TestSuite.createBothNullLead(3));
        insert leads;
        System.assertEquals(6, [SELECT count() FROM Lead]);
    }
    
    @isTest
    private static void testScheduler() {
        Test.startTest();
        String jobName = 'Leads Cleanup Activity';
        String cronExp = '0 10 12 1/1 * ? *';
        LeadsCleaningScheduler schedulable = new LeadsCleaningScheduler();
        Id jobId = System.schedule(jobName, cronExp, schedulable);
        Test.stopTest();
        System.assertNotEquals(null, jobId);
    }
}