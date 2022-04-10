//equals method
String str1 = 'Bala';
String str2 = 'bala';
Boolean isEqual = str2.equals(str1);
System.debug('Outcome is: ' + isEqual);

//equalsIgnoreCase method
String str1 = 'Bala';
String str2 = 'bALA';
Boolean isEqual = str2.equalsIgnoreCase(str1);
System.debug('Outcome is: ' + isEqual);

//contains method
String str1 = 'I am a student and I am going to school';
String str2 = 'Student';
Boolean isContain = str1.contains(str2);
System.debug('Does it contains? ' + isContain);

//containsIgnoreCase method
String str1 = 'I am a student and I am going to school';
String str2 = 'Student';
Boolean isContain = str1.containsIgnoreCase(str2);
System.debug('Does it contains? ' + isContain);

//containsAny method
String str1 = 'Hello, I am a Software Developer';
String str2 = 'xyzH';
Boolean isContainsAny = str1.containsAny(str2);
System.debug('Does it containsAny? ' + isContainsAny);

//length method
String str = 'Hello  Salesforce!?%^*';
Integer count = str.length();
System.debug('length is: ' + count);

//trim method
String str = '   Hello I am from United States     ';
Integer lengthBeforeTrimming = str.length();
System.debug('lenght before trimming: ' + lengthBeforeTrimming);
str = str.trim();
System.debug('String after trimming: ' + str);
Integer lengthAfterTrimimng = str.length();
System.debug('length after trimming: ' + lengthAfterTrimimng);

//toUpperCase method
String str = 'Hello, I am a student';
str = str.toUpperCase();
System.debug('String after upper casing: ' + str);

//toLowerCase method
String str = 'Hello, I am a student';
str = str.toLowerCase();
System.debug('String after lower casing: ' + str);