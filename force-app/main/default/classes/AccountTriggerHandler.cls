public with sharing class AccountTriggerHandler {

    public static void beforeInsert(List<Account> newAccounts) {
        populateAccountFields(newAccounts);
    }

    public static void beforeUpdate(List<Account> newAccounts) {
        populateAccountFields(newAccounts);
    }

    private static void populateAccountFields(List<Account> accounts) {
        for(Account acc : accounts) {
            if(acc.Type == null || String.isBlank(acc.Type)) {
                acc.Type = 'Prospect';
            }
            if(acc.Active__c == null || String.isBlank(acc.Active__c)) {
                acc.Active__c = 'Yes';
            }
        }
    }
}