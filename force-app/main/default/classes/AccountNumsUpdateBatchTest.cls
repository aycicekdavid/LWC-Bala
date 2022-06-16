@isTest
public class AccountNumsUpdateBatchTest {

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
    private static void testBatch() {
        Test.startTest();
        AccountNumsUpdateBatch batchable = new AccountNumsUpdateBatch();
        Database.executeBatch(batchable, 50);
        Test.stopTest();
        for(Account acc : [SELECT Id, AccountNumber FROM Account]) {
            System.assertEquals('ACC123456', acc.AccountNumber);
        }
    }
    
}