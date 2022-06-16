public with sharing class CommonUtility {
    public static void createLog(String status, String targetType, String targetName, String message) {
        Application_Log__c log = new Application_Log__c();
        log.Status__c = status;
        log.Target_Type__c = targetType;
        log.Target_Name__c = targetName;
        log.Message__c = message;
        insert log;
    }
}