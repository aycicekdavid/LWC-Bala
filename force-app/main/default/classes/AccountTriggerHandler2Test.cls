@isTest
public class AccountTriggerHandler2Test {
	@TestSetup
    private static void testSetup() {
        List<Id> accountIds = new List<Id>();
        List<Account> accounts = TestSuite.createAccounts(2);
        insert accounts;
        List<Account> insertedAccounts = [SELECT Id, Rating FROM Account];
        System.assertEquals(2, [SELECT count() FROM Account]);
        for(Account acc : insertedAccounts) {
            accountIds.add(acc.Id);
            System.assertEquals('Cold', acc.Rating);
        }
        List<Case> cases = TestSuite.createCases(accountIds);
        insert cases;
        System.assertEquals(2, [SELECT count() FROM Case]);
    }
    
    @isTest
    public static void testAccRatingChange() {
        //Hot test
        List<Account> accounts = [SELECT Id, Rating FROM Account];
        for(Account acc : accounts) {
            acc.Rating = 'Hot';
        }
        update accounts;
        
        List<Case> existingCases = [SELECT Id, Priority, Account.Rating FROM Case];
        for(Case cs : existingCases) {
            System.assertEquals('High', cs.Priority);
        }
    }
    
    @isTest
    public static void testAccRatingChange2() {
        //Hot test
        List<Account> accounts = [SELECT Id, Rating FROM Account];
        for(Account acc : accounts) {
            acc.Rating = 'Warm';
        }
        update accounts;
        
        List<Case> existingCases = [SELECT Id, Priority, Account.Rating FROM Case];
        for(Case cs : existingCases) {
            System.assertEquals('Medium', cs.Priority);
        }
    }
}