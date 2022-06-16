public with sharing class CustomMetadataHelper {

    public static Decimal getThreshold(String allowanceType) { //Internet Allowance
        allowanceType = allowanceType.replace(' ', '_'); //Internet_Allowance
        //getInstance
        Allowance_Threshold__mdt record = Allowance_Threshold__mdt.getInstance(allowanceType);
        //SOQL
        Allowance_Threshold__mdt record1 = [SELECT Threshold__c FROM Allowance_Threshold__mdt 
                                        WHERE DeveloperName = :allowanceType 
                                        LIMIT 1];
        return record.Threshold__c;
    }

    public static Decimal getCurrencyRate(String isoCode) {
        Currency_Conversion__mdt record = Currency_Conversion__mdt.getInstance(isoCode);
        return record.Rate__c;
    }

    public static String getEndpoint(String methodName) {
        Integration_Info__mdt record = Integration_Info__mdt.getInstance(methodName);
        return record.URL__c;
    }

}