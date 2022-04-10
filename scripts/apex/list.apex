//create an empty list => i would like to store student names => List of Strings
List<String> names = new List<String>();

//create an empty list => i would like to store students age => List of Integer
List<Integer> ages = new List<Integer>();

//create an empty list => I would like to store account sobjects => List of Account
List<Account> accounts = new List<Account>();

//add method
List<String> names = new List<String>();
names.add('Mustafa');
names.add('AY');
names.add('Sri');
names.add('AY');
System.debug(names);

List<Integer> ages = new List<Integer>();
ages.add(30);
ages.add(31);
ages.add(30);
System.debug(ages);

//create an sobject record. In this use case lets take account
//sObject obj = new sObject();
Account acc = new Account();
acc.Name = 'My First Account';
acc.AccountNumber = 'ABC123456';
acc.Type = 'Customer - Direct';
acc.AnnualRevenue = 200000;

Allowance__c allowance = new Allowance__c();
allowance.Allowance_Type__c = 'House Rent Allowance';
allowance.Amount__c = 3000.00;
allowance.Paid__c = false;

//create a list of contact records. i need to add up 2 contact records
List<Contact> contacts = new List<Contact>();

Contact con1 = new Contact();
con1.FirstName = 'Kathy';
con1.LastName = 'Test';
con1.Email = 'kathy@test.com';
contacts.add(con1);

Contact con2 = new Contact();
con2.FirstName = 'Sri';
con2.LastName = 'Devi';
con2.Email = 'sridevi@test.com';
contacts.add(con2);
contacts.add(con2);

System.debug(contacts);

//contains method
List<String> fruits = new List<String>{'Apple', 'Pomogranite', 'Pineapple'};
String fruit = 'Banana';
Boolean isExist = fruits.contains(fruit);
System.debug(isExist);

//collection to store 2 allowances
List<Allowance__c> allowances = new List<Allowance__c>();

//allowance 1
Allowance__c allowance1 = new Allowance__c();
allowance1.Allowance_Type__c = 'House Rent Allowance';
allowance1.Amount__c = 2000.00;
allowances.add(allowance1);

//allowance 2
Allowance__c allowance2 = new Allowance__c();
allowance2.Allowance_Type__c = 'Internet Allowance'; //
allowance2.Amount__c = 500.00;
allowances.add(allowance2);

//create an allowance to check the existance in the list
Allowance__c test = new Allowance__c();
test.Allowance_Type__c = 'Internet Allowance';
test.Amount__c = 500.00;

Boolean isExist = allowances.contains(test);
System.debug(isExist);

//get method
//                                      index=0   index=1   index=2  index=3
List<String> cities = new List<String>{'Houston', 'Fawley', 'Miami', 'New Jersey'};
String city1 = cities.get(3);
System.debug(city1);

//isEmpty method
List<Integer> postalCodes = new List<Integer>();
System.debug(postalCodes.isEmpty());
postalCodes.add(0);
System.debug(postalCodes.isEmpty());

//sort method
List<String> cities = new List<String>{'Houston', 'Fawley', 'Miami', 'New Jersey'};
System.debug('Before Sorting: ' + cities);
System.debug(cities.get(0));
cities.sort();
System.debug('After Sorting: ' + cities);
System.debug(cities.get(0));

List<Integer> rollNumbers = new List<Integer>{101, 109, 100, 200, 500, 300};
System.debug('Before Sorting: ' + rollNumbers);
rollNumbers.sort();
System.debug('After Sorting: ' + rollNumbers);

//size method
List<String> cities = new List<String>{'Houston', 'Fawley', 'Miami', 'New Jersey'};
Integer count = cities.size();
System.debug(count);