//WHILE LOOP

Integer num = 1;        //1             //2
while(num <= 10) {      //1<=10 => true //2<=10=>true
    System.debug(num);  //1             //2....10
    num = num+1;        //1+1 = 2       //2+1=3
}

//DO WHILE LOOP

Integer num = 1;
do {
    System.debug(num);
    num = num+1;  
} while(num <= 10);

                                        0               1           2           999
List<String> students = new List<String>{'Student 1', 'Student 2', 'Student 3','Student 1000'}; => 1000
//Integer count = students.size();
Integer index = 0;
while(index < 10) {
    students.get(index);
    index++;
}