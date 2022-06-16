@isTest
public class AllowanceTriggerHandlerTest {

    @TestSetup
    private static void testSetup() {
        List<Allowance__c> allowances = TestSuite.getValidAllowances(2);
        insert allowances;
        List<Allowance__c> allowancesInserted = [SELECT Id FROM Allowance__c];
        System.assertEquals(2, allowancesInserted.size());
        System.assertEquals(2, [SELECT count() FROM Allowance__c]);
    }
    
    @isTest
    private static void testInvalidAllowances() {
        try {
            List<Allowance__c> allowances = TestSuite.getInvalidAllowances(2);
        	insert allowances;
        } catch(Exception ex) {
            System.assert(ex != null);
            System.assert(ex.getMessage().contains(Label.Allowance_Threshold_Error));
        }
        System.assertEquals(2, [SELECT count() FROM Allowance__c]);
    }
    
    @isTest
    private static void testUpdateValidAllowances() {
        //old data
        Map<Id, Allowance__c> allowances = new Map<Id, Allowance__c>([SELECT Id, Amount__c FROM Allowance__c]);
        for(Allowance__c al : allowances.values()) {
            al.Amount__c = 400;
        }
        update allowances.values();
        
        //get newest data
        Map<Id, Allowance__c> newAllowances = new Map<Id, Allowance__c>([SELECT Id, Amount__c FROM Allowance__c]);
        for(Allowance__c al : allowances.values()) {
            Allowance__c newAl = newAllowances.get(al.Id);
            System.assertEquals(al.Amount__c, newAl.Amount__c);
        }
    }
    
}