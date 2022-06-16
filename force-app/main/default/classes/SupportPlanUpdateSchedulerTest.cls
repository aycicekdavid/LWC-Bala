@isTest
public class SupportPlanUpdateSchedulerTest {

    @TestSetup
    private static void testSetup() {
        //create accounts
        List<Account> accounts = TestSuite.createAccounts(3);
        accounts[0].CustomerPriority__c = 'High';
        accounts[1].CustomerPriority__c = 'Medium';
        accounts[2].CustomerPriority__c = 'Low';
        insert accounts;
        
        //do asserts
        System.assertEquals(3, [SELECT count() FROM Account]);
        
        //create cases
        List<Id> accountIds = new List<Id>();
        for(Account acc : [SELECT Id FROM Account]) {
            accountIds.add(acc.Id);
        }
        List<Case> cases = TestSuite.createCases(accountIds);
        insert cases;
        System.assertEquals(3, [SELECT count() FROM Case]);
        for(Case cs : [SELECT Support_Plan__c FROM Case]) {
            System.assertEquals(null, cs.Support_Plan__c);
        }
    }
    
    @isTest
    private static void testScheduler() {
        Test.startTest();
        String jobName = 'Support Plan Update Job';
        String cronExp = '20 30 8 10 2 ? ';
        SupportPlanUpdateScheduler schedulable = new SupportPlanUpdateScheduler();
        Id jobId = System.schedule(jobName, cronExp, schedulable);
        Test.stopTest();
        System.assertNotEquals(null, jobId);
    }

    @isTest
    private static void testBatch() {
        Test.startTest();
        SupportPlanUpdateBatch batchable = new SupportPlanUpdateBatch();
        Database.executeBatch(batchable, 50);
        Test.stopTest();
        for(Case cs : [SELECT Support_Plan__c, Account.CustomerPriority__c FROM Case]) {
            System.assert(cs.Account.CustomerPriority__c=='High' ? cs.Support_Plan__c=='Premium'
            : cs.Account.CustomerPriority__c=='Medium' ? cs.Support_Plan__c=='Standard'
            : cs.Support_Plan__c=='Basic');
        }
    }
}