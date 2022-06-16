@isTest
public class AccountProcessorTest {

    @TestSetup
    private static void testSetup() {
        //create accounts
        List<Account> accounts = TestSuite.createAccounts(3);
        insert accounts;
        System.assertEquals(3, [SELECT count() FROM Account]);
        
        //create contacts
        List<Id> accountIds = new List<Id>();
        for(Account acc : [SELECT Id FROM Account]) {
            accountIds.add(acc.Id);
        }
        List<Contact> contacts = TestSuite.getContacts(accountIds);
        insert contacts;
        System.assertEquals(3, [SELECT count() FROM Contact]);
    }
    
    @isTest
    private static void testCountContacts() {
        Test.startTest();
        List<Account> accounts = [SELECT Id, Number_of_Contacts__c FROM Account];
        List<Id> accountIds = new List<Id>();
        for(Account acc : accounts) {
            accountIds.add(acc.Id);
            System.assertEquals(null, acc.Number_Of_Contacts__c);
        }
        AccountProcessor.countContacts(accountIds);
        Test.stopTest();
        List<Account> accountsLatest = [SELECT Id, Number_of_Contacts__c FROM Account];
        for(Account acc : accountsLatest) {
            System.assertEquals(1, acc.Number_Of_Contacts__c);
        }
    }
    
}