//newInstance method
Integer hour = 3; //3+1=4 hrs => 4:15:05.345
Integer minutes = 74; //74+1=75 min // 1hr, 15 min
Integer seconds = 64; // 64+1=65 sec // 1min, 5 sec
Integer millis = 1345; //1min, 345 sec
Time tm = Time.newInstance(hour, minutes, seconds, millis);
System.debug('Time is: ' + tm);

//hour, minute & second methods
Time tm = Time.newInstance(3, 23, 10, 400);
Integer hours = tm.hour();      System.debug(hours);
Integer minutes = tm.minute();  System.debug(minutes);
Integer seconds = tm.second();  System.debug(seconds);

//addHours, addMinutes & addSeconds