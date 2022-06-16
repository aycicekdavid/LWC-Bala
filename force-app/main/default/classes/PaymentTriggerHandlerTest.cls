@isTest
public class PaymentTriggerHandlerTest {

    //3 scenarios
    //1. create bad payments => receive the error
    //2. create good payments => success message => Amount COnverted to USD
    //3. Query existing payments. Update either currency incurred in or amount incurred => Amount Converted to USD

    @TestSetup
    private static void testSetup() {
        List<Payment__c> payments = TestSuite.getValidPayments(2);
        insert payments;
        List<Payment__c> paymentsInserted = [SELECT Id, Amount_Converted_to_USD__c FROM Payment__c];
        System.assertEquals(2, paymentsInserted.size());
        for(Payment__c pay : paymentsInserted) {
            System.assert(pay.Amount_Converted_to_USD__c != null);
            System.assertNotEquals(null, pay.Amount_Converted_to_USD__c);
        }
    }
    
    @isTest
    private static void testInvalidPaymentsCreation() {
        try {
            List<Payment__c> payments = TestSuite.getInvalidPayments(2);
        	insert payments;
        } catch(Exception ex) {
            System.assert(ex != null);
        }
        List<Payment__c> availablePayments = [SELECT Id FROM Payment__c];
        System.assertEquals(2, availablePayments.size());
    }
    
    @isTest
    private static void testInvalidPaymentsUpdate() {
        try {
            List<Payment__c> payments = [SELECT Id, Amount_Incurred__c FROM Payment__c];
            payments[0].Amount_Incurred__c = null;
            update payments;
        } catch(Exception ex) {
            System.assert(ex != null);
        }
        List<Payment__c> availablePayments = [SELECT Id FROM Payment__c];
        System.assertEquals(2, availablePayments.size());
    }
    
    @isTest
    private static void testAmountUpdate() {
        //old payments
        Map<Id, Payment__c> oldPayments = new Map<Id, Payment__c>([SELECT Id, Amount_Incurred__c, Amount_Converted_to_USD__c
                                       FROM Payment__c]);
        for(Payment__c pay : oldPayments.values()) {
            pay.Amount_Incurred__c = 300;
        }
        update oldPayments.values();
        
        //new payments
        Map<Id, Payment__c> newPayments = new Map<Id, Payment__c>([SELECT Id, Amount_Incurred__c, Amount_Converted_to_USD__c
                                       FROM Payment__c]);
        for(Payment__c newPay : newPayments.values()) {
            Payment__c oldPay = oldPayments.get(newPay.Id);
            System.assertNotEquals(newPay.Amount_Converted_to_USD__c, oldPay.Amount_Converted_to_USD__c);
        }
    }
    
}