public with sharing class AccountTriggerHandler {

    public static void beforeInsert(List<Account> newAccounts) {
        populateAccountFields(newAccounts);
        for(Account acc : newAccounts) {
            if(acc.Phone == null) {
                acc.addError(Label.Phone_Mandatory);
            }
            if(acc.AccountNumber == null) {
                acc.addError('Please input a valid account number before you save account record!');
            }
        }
    }

    public static void beforeUpdate(Map<Id,Account> newAccounts, Map<Id,Account> oldAccounts) {
        populateAccountFields(newAccounts.values());
    }

    public static void beforeDelete(Map<Id,Account> oldAccounts) {
        deleteCases(oldAccounts.keySet());
        deleteOpps(oldAccounts.keySet());
    }

    /**************** SAVE ******************/

    public static void afterInsert(Map<Id,Account> newAccounts) {
        
    }

    public static void afterUpdate(Map<Id,Account> newAccounts, Map<Id,Account> oldAccounts) {
        //is account converted from prospect to customer?
        Set<Id> idsToSendEmail = new Set<Id>();
        for(Account newAcc : newAccounts.values()) { //1000 Accounts
            Account oldAcc = oldAccounts.get(newAcc.Id);
            if(newAcc.Type.containsIgnoreCase('Customer') && oldAcc.Type == 'Prospect') {
                idsToSendEmail.add(newAcc.Id); //10 Acccounts
            }
        }
        //send emails
        sendEmailsToCustomers(idsToSendEmail);
    }

    public static void afterDelete(Map<Id,Account> oldAccounts) {
        
    }

    public static void afterUndelete(Map<Id,Account> newAccounts) {
        
    }

    private static void populateAccountFields(List<Account> accounts) {
        for(Account acc : accounts) {
            //populate type
            if(acc.Type == null || String.isBlank(acc.Type)) {
                acc.Type = 'Prospect';
            }
            //populate active
            if(acc.Active__c == null || String.isBlank(acc.Active__c)) {
                acc.Active__c = 'Yes';
            }
            //populate rating
            if(acc.Industry == 'Banking' || acc.Industry == 'Healthcare') {
                acc.Rating = 'Hot';
            }
            //populate owernship
            if(acc.NumberOfEmployees < 10000) {
                acc.Ownership = 'private';
            } else if(acc.NumberOfEmployees >= 10000 && acc.NumberOfEmployees <= 100000) {
                acc.Ownership = 'Other';
            } else if(acc.NumberOfEmployees > 100000) {
                acc.Ownership = 'Public';
            }
        }
    }

    private static void sendEmailsToCustomers(Set<Id> idsToSendEmail) {
        //get accounts along with its children contacts
        List<Messaging.SingleEmailMessage> messages = new List<Messaging.SingleEmailMessage>();
        List<Account> accounts = [SELECT Id, Name, 
                                    (SELECT Id, Email FROM Contacts WHERE Email != null) 
                                    FROM Account
                                    WHERE Id IN :idsToSendEmail];
        //iterate over accounts
        for(Account acc : accounts) {
            //prepare email for each account
            Messaging.SingleEmailMessage msg = new Messaging.SingleEmailMessage();
            msg.setSubject('Hello ' + acc.Name);
            msg.setPlainTextBody('Thanks for becoming our customer. Happy to server you well!');

            //prepare collection email addresses
            List<String> emailAddresses = new List<String>();
            for(Contact con : acc.Contacts) {
                emailAddresses.add(con.Email);
            }
            msg.setToAddresses(emailAddresses);
            System.debug(msg);
            messages.add(msg);
        }
        
        try {
            //send emails
            Messaging.sendEmail(messages);
        } catch(Exception ex) {
            System.debug(ex.getMessage());
            System.debug(ex.getStackTraceString());
        }
        
    }

    private static void deleteCases(Set<Id> accountIds) {
        //Approach 1
        /*
        List<Case> casesToDelete = new List<Case>(); //using heap memory (1) 
        List<Account> accounts = [SELECT Id, (SELECT Id FROM Cases) FROM Account WHERE Id IN :accountIds]; //heap (2)
        for(Account acc : accounts) { //1000 records
            casesToDelete.addAll(acc.Cases);
        }
        delete casesToDelete; //4
        */

        //Approach 2
        List<Case> cases = [SELECT Id FROM Case WHERE AccountId IN :accountIds]; //heap(1)
        System.debug(cases);
        try {
            delete cases; //4
        } catch(Exception ex) {
            System.debug(ex.getMessage());
        }
        
    }

    private static void deleteOpps(Set<Id> accountIds) {
        List<Opportunity> opps = [SELECT Id FROM Opportunity WHERE AccountId IN :accountIds];
        try {
            delete opps;
        } catch(Exception ex) {
            System.debug(ex.getMessage());
        }        
    }
}