Integer rank = 4;
switch on rank { //4
    when 1 {
        System.debug('First Rank');
    }
    when 2 {
        System.debug('Second Rank');
    }
    when 3 {
        System.debug('Third Rank');
    }
    when 4 {
        System.debug('Fourth Rank');
    }
    when 5 {
        System.debug('Fifth Rank');
    }
    when else {
        System.debug('Not in top 5');
    }
}

//Show greeting
//Hey, ! Good morning.
public String sendGreetings(String studentName) {
    String greeting;
    if(studentName != null && studentName != '') {
        greeting = 'Hey, ' + studentName + '! Good morning.';
    }
    return greeting;
}