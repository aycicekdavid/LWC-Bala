public class AccountController {

    public List<Account> accounts = new List<Account>();

    public AccountController() {
        System.debug('AccountController  0 args Constructor has been ivoked!');
    }

    public AccountController(List<Account> accounts) {
        System.debug('AccountController 1 arg Constructor has been ivoked!');
        this.accounts = accounts;
    }

    //method 1 uses that
    //method 2 populating accounts
    //method 3 uses that

    //method to return contacts with email != null
    public static List<Contact> getContacts() {
        List<Contact> contacts = [SELECT Id, Email, Phone 
                                FROM Contact
                                WHERE Email != null];
        return contacts;
    }

    //method that returns all accounts whose name contains the given searchKey
    public List<Account> searchAccounts(String searchKey) { //test => test%
        searchKey = '%' + searchKey + '%';
        List<Account> accounts = [SELECT Name
                                FROM Account
                                WHERE Name LIKE :searchKey];
        return accounts;
    }

    //method that sums up the given integers and returns the outcome //2
    public Integer sum(Integer num1, Integer num2) {
        return (num1 + num2);
    }

    //method that sums up the given integers and returns the outcome //3
    public Integer sum(Integer num1, Integer num2, Integer num3) {
        return (num1 + num2 + num3);
    }

    //method that sums up the given integers and returns the outcome //any
    public Integer sum(List<Integer> nums) {
        Integer sum = 0;
        for(Integer num : nums) {
            sum = sum + num;
        }
        return sum;
    }

    public String checkExistance(String input1, String input2) { //input1=Soft, input2=Innovas
        if(input1.contains(input2)) {
            return 'YES';
        } else if(input1.length() == input2.length()) {
            return 'EQUALS';
        }
        return '';
    }

    public String checkExistanceOther(String input1, String input2) {
        String outcome = '';
        if(input1.contains(input2)) {
            outcome = 'YES';
        } else if(input1.length() == input2.length()) {
            outcome = 'EQUALS';
        }
        return outcome;
    }

    //get all the new cases and create a task for each one of them
    //=> CSR to give a call to customer with in 2 days from today
    public void createTasksForNewCases() {
        List<Task> tasks = new List<Task>();
        //1. get all the new cases
        List<Case> cases = [SELECT Id, Contact.Name, ContactPhone, OwnerId 
                            FROM Case 
                            WHERE Status = 'New'];

        //2. prepare a task for each case
        for(Case cs : cases) {
            Task tsk = new Task();
            tsk.OwnerId = cs.OwnerId;
            //tsk.Phone = cs.ContactPhone;
            tsk.Priority = 'Normal';
            tsk.WhatId = cs.Id;
            tsk.Subject = 'Call';
            tsk.ActivityDate = Date.today().addDays(2);
            //insert tsk;
            tasks.add(tsk);
        }
        //3. insert them all
        insert tasks;
    }

    /*
    Write a method => Input: List<Contact> contacts
    Inspect all the given contacts and do the below updates -
    Department = Finance => Title = Financial Analyst
    Department = Information Technology => Title = Software Engineer
    Department = Research => Title = Scientist
    */
    public void updateTitle(List<Contact> contacts) { //10 => 7 => 3
        List<Contact> contactsToUpdate = new List<Contact>();
        for(Contact con : contacts) {
            if(con.Department == 'Finance') {
                con.Title = 'Financial Analyst';
                contactsToUpdate.add(con);
            } else if(con.Department == 'Information Technology') {
                con.Title = 'Software Engineer';
                contactsToUpdate.add(con);
            } else if(con.Department == 'Research') {
                con.Title = 'Scientist';
                contactsToUpdate.add(con);
            }
        }
        update contactsToUpdate;
    }

    /* I would give you a list of accounts as input. List<Account> accounts
    if the account type is customer => go ahead, create a contact under the same account.
    FirstName = Test
    LastName = Account Name
    Email = test@test.com
    */

    /*Input: List<Id> contactIds
    Method Body: Get all the contacts whose Phone is blank & id matches with the given ids.
    And then => copy the value of parent account.phone into the phone field of contact record
    and then => update the contacts;
    Returns: void*/
    public void populatePhone(List<Id> contactIds) {
        List<Contact> contacts = [SELECT Id, Phone, Name, Account.Phone
                                    FROM Contact
                                    WHERE Phone = null
                                    AND Id IN :contactIds];
        for(Contact con : contacts) {
            con.Phone = con.Account.Phone;
            //update con;
        }
        update contacts;
    }

    /* Input: List<Contact> contacts //1000
    If Phone is not available => go ahead and populate the same with default number - 9912399123
    Returns: void
    */
    public void updatePhone(List<Contact> contacts) {
        List<Contact> contactsToUpdate = new List<Contact>();
        for(Contact con : contacts) {
            if(con.Phone == null) {
                con.Phone = '9912399123';
                contactsToUpdate.add(con);
            }
        }
        update contactsToUpdate;
    }

    /*Input: NA
    Method Body: Get all the prospect accounts and check if it has any contacts created.
    If there are no contacts available on any account => Create a contact record for the same account
    FirstName = 'Test';
    LastName = Account.Name;
    Return Type: void
    */
    public void checkContactsExistance() {
        List<Contact> contactsToCreate = new List<Contact>();
        List<Account> prospectAccounts = [SELECT Id, Name, (SELECT Id FROM Contacts)
                                        FROM Account 
                                        WHERE Type = 'Prospect'];
        for(Account acc : prospectAccounts) {
            if(acc.Contacts.isEmpty()) {
                Contact con = new Contact();
                con.AccountId = acc.Id;
                con.FirstName = 'Test';
                con.LastName = acc.Name;
                contactsToCreate.add(con);
            }
        }
        insert contactsToCreate;
    }

    /**
     * Create a number field on Account object - "Number of Contacts"
     * Input: NA
     * Method Body: Get all the accounts along with their children contacts
     * Count the number of contacts available on each account and update the field "Number of Contacts"
     * Save accounts
     * Return Type: NA
     */
    public void countContacts() {
        System.debug('CountContacts method execution has started!');
        List<Account> accounts = [SELECT Id, Number_of_Contacts__c, (SELECT Id FROM Contacts)
                                FROM Account];
        for(Account acc : accounts) {
            acc.Number_of_Contacts__c = acc.Contacts.size();
        }
        update accounts;
    }

    
}