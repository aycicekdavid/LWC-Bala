//FOR LOOP
for(Integer num=1; num<11; num++) {
    System.debug(num);
}

List<String> countries = new List<String>{'United States', 'United Kingdom', 'United Arab Emirates', 'India'};
for(Integer index=0; index<countries.size(); index++) {
    System.debug(countries.get(index));
}

//FOR EACH LOOP
List<String> countries = new List<String>{'United States', 'United Kingdom', 'United Arab Emirates', 'India'};
//for(data_type var_name : list_or_set) {
//
//}

for(String country : countries) {
    System.debug(country);
}

//Caller will send an array/list of integers. the method sum them up and return the sum back
//[10, 4, 24, 10];
public Integer sum(List<Integer> numbers) {
    Integer sum = 0;                //0
    for(Integer num : numbers) {    //10            //4             //24            //10            
        sum = sum + num;            //sum=0+10=10   //sum=10+4=14   //sum=14+24=38  //sum=38+10=48
    }
    return sum; //48
}

List<Integer> numbers = new List<Integer>{10, 20, 24, 14, 5};
SampleClass sc = new SampleClass();
Integer outcome = sc.sum(numbers);
System.debug(outcome);


//i have data in a map
//map => key, value
//keySet method/values method
//RollNo : Student Name
Map<Integer, String> rollVsName = new Map<Integer, String>{
    101 => 'Jeff',
    102 => 'John',
    103 => 'Mike'
};
Set<Integer> rolls = rollVsName.keySet();
for(Integer roll : rolls) {
    String name = rollVsName.get(roll);
    System.debug(roll + ' : ' + name);
}

List<String> names = rollVsName.values();
for(String name : names) {
    System.debug(name);
}

//Map<Account Name, Account Record>
//Account Name => Annual Revenue
Map<String, Account> accounts = new Map<String, Account>();

Account acc1 = new Account();
acc1.Name = 'Account 1';
acc1.AnnualRevenue = 2000000;
accounts.put('Account 1', acc1);

Account acc2 = new Account();
acc2.Name = 'Account 2';
acc2.AnnualRevenue = 3000000;
accounts.put('Account 2', acc2);

List<Account> accountRecords = accounts.values();

for(Account acc : accountRecords) {
    String accountName = acc.Name;
    Integer revenue = acc.AnnualRevenue;
    System.debug(accountName + ' => ' + revenue);
}