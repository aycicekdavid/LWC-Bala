AccountController ctrl = new AccountController();
ctrl.createTasksForNewCases();

List<Account> accounts = [SELECT Id FROM Account];
AccountController ctrl = new AccountController();
ctrl.countContacts();
ctrl.accounts = accounts;

AccountController.getContacts();

//Assignment 1
//UC1
Assignment1 asgmt = new Assignment1();
List<Account> accounts = asgmt.getAccounts();
System.debug(accounts);

//UC2
List<Allowance__c> allowances = [SELECT Id, Status__c FROM Allowance__c];
Assignment1 asgmt = new Assignment1();
asgmt.populateAllowanceStatus(allowances);

//UC3
Map<Id, Account> accounts = new Map<Id, Account>([SELECT Name, AccountNumber FROM Account]);
Assignment1 asgmt = new Assignment1();
asgmt.updateAccountNumbers(accounts);

//UC4
Assignment1 asgmt = new Assignment1();
asgmt.countValidContacts();

//UC5
Assignment1 asgmt = new Assignment1();
asgmt.populateCasePriority();