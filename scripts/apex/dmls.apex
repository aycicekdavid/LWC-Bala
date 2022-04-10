//DML's - insert, update, delete & undelete

//INSERT DML

//3 steps
public static void createAccount() {
    //step 1
    Account acc = new Account();
    //step 2
    acc.Name = 'Bala Test';
    acc.Type = 'Prospect';
    acc.AccountNumber = 'ABC12345';
    //step 3
    insert acc;
}

public static void createAccounts() {
    List<Account> accounts = new List<Account>();
    //2 accounts
    Account acc1 = new Account();
    acc1.Name = 'Account 1';
    //insert acc1;
    accounts.add(acc1);

    Account acc2 = new Account();
    acc2.Name = 'Account 2';
    //insert acc2;
    accounts.add(acc2);

    insert accounts;
}

public static void createAllowance() {
    Allowance__c allowance = new Allowance__c();
    allowance.Allowance_Type__c = 'Internet Allowance';
    allowance.Amount__c = 100.00;
    insert allowance;
}

//I would like to craete 10 contact records with some random firstname,  lastname & email
public static void createMultipleContacts() {
    //maintain a collection
    List<Contact> contacts = new List<Contact>();

    for(Integer i=1; i<=10; i++) {
        Contact con = new Contact();
        con.FirstName = 'FirstName Test' + i;
        con.LastName = 'lastName Test' + i;
        con.Email = 'test@test.com';
        contacts.add(con);
    }

    insert contacts;
}

//UPDATE DML

public static void updateAccounts() {
    //1. get the target records
    List<Account> accounts = [SELECT Id, Name, Type FROM Account WHERE Type = null];

    //2. iterate over the records
    for(Account acc : accounts) {
        //3. populate type field
        acc.Type = 'Prospect';
        //update acc;
    }
    
    //4. update accounts
    update accounts;
}

//get the account with highest revenue and set CustomerPriority__c = High
public static void updateAccount() {
    //1. get the target records
    List<Account> accounts = [SELECT Id, CustomerPriority__c 
                            FROM Account 
                            WHERE AnnualRevenue != null 
                            ORDER BY AnnualRevenue DESC 
                            LIMIT 10];
    //2. iterate over the records
    for(Account acc : accounts) {
        acc.CustomerPriority__c = 'High';
    }
    //3. populate target field
    if(!accounts.isEmpty()) { //if(accounts.size() > 0)
        accounts[0].CustomerPriority__c = 'High';
        //accounts.get(0).CustomerPriority__c = 'High';
    }
    //you can take either 2 or 3

    //4. update accounts
    update accounts;
}

//DELETE DML
//1. delete the lead with the given id '00Q5j000008BoVOEA0'
public class MyClass {
    public static void deleteLeadRecord(Id leadId) {
        List<Lead> leads = [SELECT Id FROM Lead WHERE Id = :leadId];
        delete leads;
    }
}

Id leadId = '00Q5j000008BoVOEA0';
MyClass.deleteLeadRecord(leadId);


//2. delete the lead whose email and phone are blank
public static void deleteUnwantedLeads() {
    List<Lead> leads = [SELECT Email, Phone FROM Lead WHERE Email = null AND Phone = null]; 
    if(leads.size() > 0) { //if(!leads.isEmpty())
        delete leads;
    } //150 DML LIMIT
}

//3. I want to delete case if reason is blank. I want to delete cases if subject is blank
List<Case> cases = [SELECT Id FROM Case WHERE Reason = null OR Subject = null];
if(!cases.isEmpty()) {
    delete cases;
}

//UNDELETE DML - undelete
List<Account> accounts = [SELECT Id, Name FROM Account 
                    WHERE Name LIKE '%test%' 
                    AND isDeleted = true 
                    ALL ROWS];
System.debug(accounts);
undelete accounts;

List<Account> accounts = [SELECT Id, Name FROM Account 
                    WHERE Name LIKE '%test%'
                    ALL ROWS];
System.debug(accounts);

List<Account> accounts = [SELECT Id, Name FROM Account 
                    WHERE Name LIKE '%test%'];
System.debug(accounts);

//Database methods
Database //static methods - insert(record/collection, boolean) ? AllOrNone = false //insert(accounts)
                          - update(record/collection, false) ? AllOrNone = false
                          - delete(record/collection, boolean)



ApexClass {
    method() {
        collection = accounts;
        insert collection;

        record = contact;
        update record;

        collection = leads;
        delete collection;

        collection = cases;
        Database.SaveResult[] result = Database.insert(collection, false); //1000
    }
}
//3? 3+ 4

//I want to delete all leads whose email and phone are blank
Database.delete(collection, false);