//create notification event and then publish it
Notification_Event__e evt = new Notification_Event__e();
evt.Message__c = 'Accounts processing has been completed';
evt.Target__c = 'Accounts Batch';
EventBus.publish(evt);


public static void createLog() {
    Application_Log__c log = new Application_Log__c();
    log.Target_Name__c = '';
    log.Target_Type__c = '';
    log.Message__c = '';
    log.Status__c = '';
    log.Operator__c = '';
    insert log;
}

//30 places