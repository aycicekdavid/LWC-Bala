public with sharing class PaymentTriggerHandler {

    public static void beforeInsert(List<Payment__c> newPayments) {
        calculateAmountToUSD(newPayments);
    }

    public static void beforeUpdate(Map<Id, Payment__c> newPayments, Map<Id, Payment__c> oldPayments) {
        List<Payment__c> paymentsToCheck = new List<Payment__c>();
        for(Payment__c pay : newPayments.values()) {
            Decimal oldAmount = oldPayments.get(pay.Id).Amount_Incurred__c;
            String oldCurrency = oldPayments.get(pay.Id).Currency_Incurred_In__c;
            if(pay.Amount_Incurred__c != oldAmount || pay.Currency_Incurred_In__c != oldCurrency) {
                paymentsToCheck.add(pay);
            }
        }
        if(!paymentsToCheck.isEmpty()) {
            calculateAmountToUSD(paymentsToCheck);
        }
    }

    private static void calculateAmountToUSD(List<Payment__c> payments) {
        for(Payment__c pay : payments) {
            if(pay.Amount_Incurred__c == null || pay.Currency_Incurred_In__c == null) {
                pay.addError(Label.Currency_Mandatory);
            } else {
                Decimal crossRate = CustomMetadataHelper.getCurrencyRate(pay.Currency_Incurred_In__c);
                if(crossRate != null) {
                    pay.Amount_Converted_to_USD__c = pay.Amount_Incurred__c/crossRate;
                } 
            }
        }
    }

}