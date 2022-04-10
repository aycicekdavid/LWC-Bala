//IF STMT
//if(acc.AnnualRevenue > 1000000) {
    //lines of code
    //lines of code
//}
//line of code

Integer rank = 6;
if(rank < 5) {  //6<5 => false
    System.debug('Hey, you have got a good rank!');
}
if(rank > 5 && rank != null) {  //6>5 && 6!=null => true && true => true
    System.debug('Hey, you are in top 10');
}

//IF ELSE
if([Cond_Check]) {
    //if condition is met
} else {
    //when condition is not met
}

Integer rank = 5;
if(rank <= 5) {  //6<=5 => false
    System.debug('Hey, you have got a good rank!');
} else {
    System.debug('Hey, you are not in top 5');
}


//IF ELSE LADDER
Integer rank = 2;
if(rank == 1) { //2==1 => false
    System.debug('First Rank');
} else if(rank == 2) { //2==2 => true
    System.debug('Second Rank');
} else if(rank == 3) {
    System.debug('Third Rank');
} else if(rank == 4) {
    System.debug('Fourth Rank');
} else if(rank == 5) {
    System.debug('Fifth Rank');
} else {
    System.debug('Not in top 5');
}

Integer rank = 2;
if(rank == 1) //2==1 => false
    System.debug('First Rank');
else if(rank == 2) //2==2 => true
    System.debug('Second Rank');
else if(rank == 3)
    System.debug('Third Rank');
    System.debug('Third Rank');
else if(rank == 4)
    System.debug('Fourth Rank');
else if(rank == 5)
    System.debug('Fifth Rank');
else
    System.debug('Not in top 5');