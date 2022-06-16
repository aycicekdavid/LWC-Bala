public with sharing class Assignment1 {
    /**
     * Method Name: getAccounts
     * Input Parameters: NA
     * Return Type: List<Account>
     * Method Body: Get all the accounts whose type is not null and return the same
     */
    public List<Account> getAccounts() {
        List<Account> accounts = [SELECT Id, Name, Type, Industry 
                                FROM Account
                                WHERE Type != null];
        return accounts;
    }

    //Create a custom picklist field "Status" on Allowance object with 
    //picklist values = Submitted, Under Review, Approved, Rejected
    /**
     * Method Name: populateAllowanceStatus
     * Input Parameters: List<Allowance__c> allowances
     * Return Type: NA
     * Method Body: Go over the inputted collection of allowances
     * => Check if status is not populated
     * => If yes, get it popolated to 'Submitted'
     * => and update the only targeted allowance records
     */
    public void populateAllowanceStatus(List<Allowance__c> allowances) {
        List<Allowance__c> allowancesToUpdate = new List<Allowance__c>();
        for(Allowance__c al : allowances) {
            if(al.Status__c == null) {
                al.Status__c = 'Submitted';
                allowancesToUpdate.add(al);
            }
        }
        update allowancesToUpdate;
    }

    /**
     * Method Name: updateAccountNumbers
     * Input Parameters: Map<Id, Account> records
     * Return Type: NA
     * Method Body: Go over the inputted collection of account records
     * (Clue: You cant iterate over a map using for loop. You always need an array/list/set)
     * => Check if account number is null
     * => If yes, get it populated to 'ABC123456'
     * => and update only targeted account records
     */
    public void updateAccountNumbers(Map<Id, Account> records) {
        List<Account> accountsToUpdate = new List<Account>();
        for(Account acc : records.values()) {
            if(acc.AccountNumber == null) {
                acc.AccountNumber = 'ABC123456';
                accountsToUpdate.add(acc);
            }
        }
        update accountsToUpdate;
    }

    /**
     * Method Name: countValidContacts
     * Input Parameters: NA
     * Return Type: NA
     * Method Body: Get all the accounts along with its children contacts whose email is not null
     * => Go over the accounts, count the number of contact records
     * and update the same in Number_of_Contacts__c field of account
     */
    public void countValidContacts() {
        List<Account> accounts = [SELECT Id, Number_of_Contacts__c, 
                                (SELECT Id FROM Contacts WHERE Email != null)
                                FROM Account];
        for(Account acc : accounts) {
            acc.Number_of_Contacts__c = acc.Contacts.size();
        }
        update accounts;
    }
    
    /**
     * Method Name: populateCasePriority
     * Input Parameters: NA
     * Return Type: NA
     * Method Body: Get all the cases along with its parent account's customer priority field
     * => Do not get cases whose account's customer priority is null
     * => copy account's customer priority value into case priority field
     * => update cases
     */
    public void populateCasePriority() {
        List<Case> cases = [SELECT Id, Priority, Account.CustomerPriority__c 
                            FROM Case
                            WHERE Account.CustomerPriority__c != null];
        for(Case cs : cases) {
            cs.Priority = cs.Account.CustomerPriority__c;
        }
        update cases;
    }
}