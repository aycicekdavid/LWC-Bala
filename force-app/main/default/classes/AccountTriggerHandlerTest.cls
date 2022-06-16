@isTest
public with sharing class AccountTriggerHandlerTest {
    
    @TestSetup 
    private static void testSetup() {
        List<Account> accounts = TestSuite.createAccounts(2);
        insert accounts;
    }

    @isTest
    private static void testAccountCreation() {
        List<Account> accounts = TestSuite.createAccounts(2);
        insert accounts;
    }

}