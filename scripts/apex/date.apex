//newInstance method
//if you know the year, month & day
Integer year = 2022;
Integer month = 3;
Integer day = 12;
Date dt = Date.newInstance(year, month, day);
System.debug('Date Created is: ' + dt);

Integer year = 2023;
Integer month = 2;
Integer day = 29;
Date dt = Date.newInstance(year, month, day);
System.debug('Date Created is: ' + dt);

//today method
Date dt = Date.today();
System.debug('Date today is: ' + dt);

//addDays method
Date dt = Date.today();
Date todayPlus7 = dt.addDays(-20);
System.debug('Today Plus 7 Days: ' + todayPlus7);

//addMonths method
Date dt = Date.newInstance(2021, 12, 31);
Date nMonthsAfterJan1 = dt.addMonths(2);
System.debug('Final Date is: ' + nMonthsAfterJan1);

//addYears method
Date dt = Date.today();
Date dt2Years = dt.addYears(2);
System.debug('Date after 2 years: ' + dt2Years);

Date dt = Date.newInstance(2021, 2, 29); // 2021-03-01
Date dt2Years = dt.addYears(3); //2021+3-03-01=2024-03-01
System.debug('Date after 2 years: ' + dt2Years);

//dayBetween method
Date date1 = Date.newInstance(2022, 02, 01); //2022-03-13
Date date2 = Date.newInstance(2022, 04, 01); //2022-03-19
Integer number1 = date1.daysBetween(date2);
System.debug('Days Between 1: ' + number1);

Integer number2 = date2.daysBetween(date1);
System.debug('Days Between 2: ' + number2);

Integer mnths = date1.monthsBetween(date2);
System.debug('Months Between: ' + mnths);

//day, month, year methods
Date dt = Date.today().addDays(10); //2022-03-23
Integer day =  dt.day();    System.debug(day);
Integer month = dt.month(); System.debug(month);
Integer year = dt.year();   System.debug(year);