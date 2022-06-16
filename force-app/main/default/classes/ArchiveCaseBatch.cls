public with sharing class ArchiveCaseBatch implements Database.Batchable<sObject>, Database.Stateful {
    
    private Integer recordsProcessed = 0;
    private DateTime numOfDays = DateTime.now().addDays(Integer.valueOf(Label.Case_Archive_Period));

    public Database.QueryLocator start(Database.BatchableContext bc) {
        //identify target records
        String qeury = 'SELECT Id, CaseNumber, Subject, Description, Status, Priority, Origin '
                    + 'FROM Case '
                    + 'WHERE CreatedDate < :numOfDays';
        return Database.getQueryLocator(qeury);
    }

    public void execute(Database.BatchableContext bc, List<Case> cases) {
        //business processing logic
        List<Case__b> bigRecords = new List<Case__b>();
        for(Case cs : cases) {
            Case__b csb = new Case__b();
            csb.Case_Number__c = cs.CaseNumber;
            csb.Subject__c = cs.Subject;
            csb.Description__c = cs.Description;
            csb.Status__c = cs.Status;
            csb.Priority__c = cs.Priority;
            csb.Origin__c = cs.Origin;
            bigRecords.add(csb);
        }
        insert bigRecords;
        delete cases;
    }

    public void finish(Database.BatchableContext bc) {
        //send an email to bala (balue666@gmail.com)
        //Subject: Case Archive Batch Status
        //Body: recordsProcessed records have been archived successfully!
        //ToAddresses: balue666@gmail.com
    }

}

//Execute a batch//
ArchiveCaseBatch batchable = new ArchiveCaseBatch();
Database.executeBatch(batchable); //200 records

ArchiveCaseBatch batchable = new ArchiveCaseBatch();
Database.executeBatch(batchable, 100); //1-2000

List<String> emails = new List<String>(); // 0 elements
emails.add('');

List<String> emails = new List<String>{'test@test.com'. 'test@tst.com'};
emails.add('');

//10 leads (10 email addresses)
List<Messaging.SingleEmailMessage> msgs = new List<Messaging.SingleEmailMessage>();


for(Lead ld : leads) { //ld 1 //ld 2 //ld 3
    if(ld.Email != null && ld.Phone == null) {
        List<String> emails = new List<String>{ld.Email};
        //emails.add(ld.Email); //{'ld3@test.com'}
        Messaging.SingleEmailMessage msg = new Messaging.SingleEmailMessage();
        msg.setSubject('');
        msg.setPlainTextBody('');
        msg.setToAddresses(emails);
        msgs.add(msg);
    }
}