@isTest
public with sharing class FutureMethodsTest {
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
        List<Contact> contacts = TestSuite.getContacts(accountIds);
        insert contacts;
        System.assertEquals(2, [SELECT count() FROM Contact]);
    }
    
    @isTest
    private static void testSendEmails() {
        List<Id> contactIds = new List<Id>();
        for(Contact con : [SELECT Id FROM Contact]) {
            contactIds.add(con.Id);
        }
        FutureMethods.sendEmailMessages(contactIds);
    }
}