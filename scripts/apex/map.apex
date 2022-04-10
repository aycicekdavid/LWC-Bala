//MAP
//create an empty of map of Integer, String
Map<Id, Account> accounts = new Map<Id, Account>();

Map<Integer, String> rollVsName = new Map<Integer, String>();
rollVsName.put(1001, null);
rollVsName.put(1002, 'Ali Khan');
rollVsName.put(1003, '');
rollVsName.put(null, null);
rollVsName.put(1002, 'Jeff Bazos');
System.debug(rollVsName);

//keySet & values methods
Map<Integer, String> rollVsName = new Map<Integer, String>{
    1001 => 'Melihcan',
    1002 => 'Kathy',
    1003 => 'Mustafa'
};
System.debug(rollVsName);
Set<Integer> rolls = rollVsName.keySet();
System.debug(rolls);
List<String> names = rollVsName.values();
System.debug(names);


//containsKey method
Map<Integer, String> rollVsName = new Map<Integer, String>{
    1001 => 'Melihcan',
    1002 => 'Kathy',
    1003 => 'Mustafa',
    1010 => null
};
rollVsName.put(1003, 'AY');
Boolean isExist1 = rollVsName.containsKey(1002);
System.debug(isExist1);
Boolean isExist2 = rollVsName.containsKey(1005);
System.debug(isExist2);

//get method
System.debug(rollVsName.get(1003));
System.debug(rollVsName.get(1010));
System.debug(rollVsName.get(1020));

//size, isEmpty methods
Map<String, String> cityVsCountry = new Map<String, String>{
    'Houston' => 'United States',
    'Miami' => 'United States',
    'Dubai' => 'United Arab Emirates',
    'Hyderabad' => 'India'
};
Boolean isEmpty = cityVsCountry.isEmpty();
System.debug(isEmpty);
Integer size = cityVsCountry.size();
System.debug(size);

//equals method
System.debug(cityVsCountry.equals(cityVsCountry));
System.debug(rollVsName.equals(cityVsCountry));