public with sharing class AccountTriggerHandler2 {
    public static void afterUpdate(Map<Id, Account> newAccounts, Map<Id, Account> oldAccounts) {
        Set<Id> accountIds = new Set<Id>();
        for(Account newAcc : newAccounts.values()) {
            Account oldAcc = oldAccounts.get(newAcc.Id);
            if(oldAcc.Rating != newAcc.Rating) {
                accountIds.add(newAcc.Id);
            }
        }
        if(!accountIds.isEmpty()) {
            updateCasePriority(accountIds);
        }
    }

    public static void updateCasePriority(Set<Id> accountIds) {
        List<Case> cases = [SELECT Id, Priority, Account.Rating 
                            FROM Case 
                            WHERE AccountId IN :accountIds];
        for(Case cs : cases) {
            if(cs.Account.Rating == 'Hot') {
                cs.Priority = 'High';
            } else if(cs.Account.Rating == 'Warm') {
                cs.Priority = 'Medium';
            } else {
                cs.Priority = 'Low';
            }
        }
        update cases;
    }
}