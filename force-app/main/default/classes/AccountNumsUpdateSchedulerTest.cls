@isTest
public class AccountNumsUpdateSchedulerTest {
	@TestSetup
    private static void testSetup() {
        List<Account> accounts = TestSuite.createAccounts(3);
        for(Account acc : accounts) {
            acc.AccountNumber = null;
        }
        insert accounts;
        for(Account acc : [SELECT Id, AccountNumber FROM Account]) {
            System.assertEquals(null, acc.AccountNumber);
        }
    }
    
    @isTest
    private static void testScheduler() {
        Test.startTest();
        String jobName = 'Accounts Numbers Update';
        String cronExp = '10 30 10 8 6 ? ';
        AccountNumsUpdateScheduler schedulable = new AccountNumsUpdateScheduler();
        Id jobId = System.schedule(jobName, cronExp, schedulable);
        Test.stopTest();
        System.assertNotEquals(null, jobId);
    }
}