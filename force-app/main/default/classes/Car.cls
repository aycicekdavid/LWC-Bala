public class Car {
    
    //Constants
    private final Decimal interestRate = 3.5;

    //Characterstics //variables
    //primitive data types
    private String color = 'red';
    private String type = 'SUV';
    private Decimal cost = 45000.09060;
    private Integer seatingCpacity = 7;
    //private Id carId = 'HyundaiI20';
    public Boolean isSold = false;
    private Date dateShipped = Date.today();
    private Integer gear;
    
    //sObject data types
    private Account acc = new Account();    
    //private Payment__c pay = new Payment__c();

    public Car() {
        
    }
    
    //Behavior //methods    
    /*
    AS = Access Specifiers
    SNS = Static or Non-Static
    RT = Return Type
    MN = Method Name
    IP = Optional Input Parameters
    */
    //AS  //SNS   //RT   //MN   //IP
    public static String findCar(String type, Decimal cost) {
        String carName = 'Hyundai i20';
        return carName;
    }
    
    public Integer changeGear() {
        gear = gear + 1;
        return gear;
    }
    
}