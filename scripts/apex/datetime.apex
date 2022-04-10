//newInstance overloaded methods
//1. when you have date & time references
Date dt = Date.today();
Time tm = Time.newInstance(7,30,20,200);
DateTime dttime = DateTime.newInstance(dt, tm);
System.debug('2 Inputs: ' + dttime);

//2. when you have year, month & day
DateTime dttime = DateTime.newInstance(2022, 3, 24);
System.debug('3 Inputs: ' + dttime);

//3. when you have year, month, day, hour, min & seconds
DateTime dttime = DateTime.newInstance(2022, 3, 26, 8, 00, 34);
System.debug('6 Inputs: ' + dttime);

//4. when you want to get date & time value of now
DateTime dttime = DateTime.now();     
System.debug('Static now: ' + dttime);

//5. when you have some long number of milli seconds
Long longmillis = 10000000000000L;
DateTime dttime = DateTime.newInstance(longmillis);
System.debug('1 Input: ' + dttime);

