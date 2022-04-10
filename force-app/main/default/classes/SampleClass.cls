public with sharing class SampleClass {
    
    //Caller will send an array/list of integers. the method sum them up and return the sum back
    //[10, 4, 24, 10];
    public Integer sum(List<Integer> numbers) {
        Integer sum = 0;                //0
        for(Integer num : numbers) {    //10            //4             //24            //10            
            sum = sum + num;            //sum=0+10=10   //sum=10+4=14   //sum=14+24=38  //sum=38+10=48
        }
        return sum; //48
    }
    
}
