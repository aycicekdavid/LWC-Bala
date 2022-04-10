//data modeling & queries

//1. 5 parts
1. Selecting the fields //SELECT
2. From what object  //FROM //1M records
3. Filter criteria   //WHERE //OPTIONAL 1000
4. Would you like to sort the results? //ORDER BY
5. would you like to limit the records? //LIMIT

* The outcome of SOQL is always a list of sobjects => List<Account>
=> List<Payment__c>
=> List<Contact>

//BASIC SOQL's
//i need all the contact records
List<Contact> contacts = [SELECT Id, FirstName, LastName, Email
                        FROM Contact];

//i would need to get all account records
//Account Name, Account Number, Account Type, Industry
List<Account> accounts = [SELECT Name, AccountNumber, Type, Industry
                        FROM Account];

//i need all cases whose status is new
//Subject, Priority, Type, Status
List<Case> cases = [SELECT Subject, Priority, Type, Status
                    FROM Case
                    WHERE Status = 'New'];

//i need all cases whose priority is high
List<Case> cases = [SELECT Subject, Priority, Type, Status
                    FROM Case
                    WHERE Priority = 'High'];

//get all accounts whose annual revenue is greater than 1M and industry is software and account number is not blank
List<Account> accounts = [SELECT Name, AccountNumber, Type, Industry
                        FROM Account
                        WHERE AnnualRevenue > 1000000
                        AND Industry = 'Software'
                        AND AccountNumber != null];
System.debug(accounts);

//i would like to get contacts whose either firstname or lastname is not blank
List<Contact> contacts = [Select Id, FirstName, LastName
                        FROM Contact
                        WHERE FirstName != null
                        OR LastName != null];

FirstName       LastName
''              'Beck'  (FALSE OR TRUE => TRUE)
'Yavuz'         ''      (TRUE OR FALSE => TRUE)
''              ''      (FALSE OR FALSE => FALSE)
'Test'          'Test'  (TRUE OR TRUE => TRUE)

//all accounts either having (annual revenue greater 2M) or (not a prospect account & account number != null)
List<Account> accounts = [SELECT Name, AccountNumber, Type, Industry
                        FROM Account 
                        WHERE (AnnualRevenue > 2000000)
                        OR (Type != 'Prospect'
                            AND AccountNumber != null)];

//get all contacts whose lastname contains 'smith'
//=> The lastname either can start with => Smith Jose, Josmith Mike, Mike Smith
//AccountNumber
List<Contact> contacts = [Select Id, FirstName, LastName 
                        FROM Contact
                        WHERE LastName LIKE '%smith%']; // all 3 records

List<Contact> contacts = [Select Id, FirstName, LastName 
                        FROM Contact
                        WHERE LastName LIKE '%smith']; //last one record

List<Contact> contacts = [Select Id, FirstName, LastName 
                        FROM Contact
                        WHERE LastName LIKE 'smith%'
                        AND FirstName LIKE '%test']; //first one record

//i want to get the won oppprtunity having the highest amount
List<Opportunity> opps = [SELECT Id, Name, amount
                        FROM Opportunity
                        WHERE StageName = 'Closed Won'
                        ORDER BY Amount DESC
                        LIMIT 1];

//2. Bind variables
String prospectStage = 'Prospect';
Decimal amountValue = 2000000.00;
List<Opportunity> opps = [SELECT Id, Name, Amount
                        FROM Opportunity
                        WHERE StageName = 'Prospect'];
List<Opportunity> opps = [SELECT Id, Name, Amount
                        FROM Opportunity
                        WHERE StageName = :prospectStage
                        AND Amount > :amountValue];

public static List<Account> getAccountsByRevenue(Decimal amount) {
    List<Account> accounts = [Select Id, Name, AnnualRevenue
                            FROM Account
                            WHERE AnnualRevenue >= :amount];
    return accounts;
}


//3. Relationships in SOQL
// One (Parent) - Many (Child) Relationship
//Child Query - I would like to get the data of parent as well

//standard relationship
//Query on Child => Parent
//i want all contacts along with their account's phone, industry
//condition - whose email is populated 
List<Contact> contacts = [SELECT Id, FirstName, LastName, Email, Account.Phone, Account.Industry
                        FROM Contact
                        WHERE Email != null];
System.debug(contacts);
for(Contact con : contacts) {
    if(con.Email.contains('softinnovas')) {
        
    }
    if(con.Account.Phone != null) {

    }
}

//custom relationship
//ALLOWANCE <=> Account
// i want to get all allowance whose amount is greater than 0
//along with its account Name, Phone
List<Allowance__c> allowances = [SELECT Id, Allowance_Type__c, Amount__c, Account__r.Name, Account__r.Phone, Account__r.CustomerPriority__c
                                FROM Allowance__c
                                WHERE Amount__c > 0
                                AND Account__r.Phone != null];

//Query on Parent => Child info as well
//I would like to get all accounts whose type is not prospect 
//along with its cases
List<Account> accounts = [SELECT Id, Name, (SELECT CaseNumber, Status FROM Cases)
                        FROM Account
                        WHERE Type != 'Prospect'];

//get accounts whose type is not null
//along with its allowances
List<Account> accounts = [SELECT Id, Name, (SELECT Amount__c, Allowance_Type__c FROM Allowances__r)
                        FROM Account
                        WHERE Type != null];
for(Account acc : accounts) {
    //acc.Id;
    //acc.Name;
    //acc.Allowances__r;
    System.debug(acc);
    List<Allowance__c> allowances = acc.Allowances__r;
    for(Allowance__c alw : allowances) {
        System.debug(alw);
    }
}

//I would like to understand the number of allowances created from each account;
//update the field Allowances_Count__c on Account
List<Account> accounts = [SELECT Id, Allowances_Count__c, (SELECT Id FROM Allowances__r WHERE Status__c = 'Approved')
                        FROM Account];
for(Account acc : accounts) {
    acc.Allowances_Count__c = acc.Allowances__r.size();
}
update accounts;


SOSL
=====

3 parts

1. What would you like to search for //FIND
2. In what type of fields you want to search //IN
3. In case you have an occurance, what are the target results you are interested in? //RETURNING

List<List<sObject> results = [FIND {SFDC}
                            IN NAME FIELDS
                            RETURNING Contact(FirstName, LastName), Lead(FirstName, LastName)];