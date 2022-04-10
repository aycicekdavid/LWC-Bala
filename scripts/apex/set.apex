//SET
//create a set of integers
Set<Integer> rollNumbers = new Set<Integer>();
rollNumbers.add(100);
rollNumbers.add(110);
rollNumbers.add(105);
System.debug(rollNumbers);
rollNumbers.add(106);
rollNumbers.add(105);
System.debug(rollNumbers);

Set<String> countries = new Set<String>();
countries.add('United States');
countries.add('United Kingdom');
Boolean entry1 = countries.add('United Arab Emirates');
Boolean entry2 = countries.add('United Arab Emirates');
System.debug(countries);
System.debug(entry1);
System.debug(entry2);

//contains method
Set<String> flowers = new Set<String>{'Lotus', 'Sunflower', 'Lilly', 'Rose', 'Cauliflower'};
Boolean isExist1 = flowers.contains('Lotus');
System.debug(flowers.contains('Lotus'));
Boolean isExist2 = flowers.contains('Tomatoes');
System.debug(isExist2);

//isEmpty method
Set<String> flowers = new Set<String>{'Lotus', 'Sunflower', 'Lilly', 'Rose', 'Cauliflower'};
Boolean emptyOrNot = flowers.isEmpty();
System.debug(emptyOrNot);
Set<Integer> numbers = new Set<Integer>();
System.debug(numbers.isEmpty());

//size method
Integer count1 = flowers.size();
System.debug(count1); //5
Integer count2 = numbers.size();
System.debug(count2); //0