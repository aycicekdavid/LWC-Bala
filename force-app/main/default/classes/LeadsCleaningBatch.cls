public with sharing class LeadsCleaningBatch implements Database.Batchable<sObject>, Database.Stateful{
    
    public Database.QueryLocator start(Database.BatchableContext bc){
        //identify target records
        
        String query = 'SELECT Id, Phone, Email, LastName FROM Lead WHERE CreatedDate = TODAY';
        return Database.getQueryLocator(query);
        
    }
    public void execute(Database.BatchableContext bc, List<Lead> leads){
        //buisness processsing logic 
        List<Lead> leadsList = new List<Lead>();
        //List<Lead> leadsToSendEmail = new List<Lead>(); -> we used listOfEmailAddresses so we dont need this one.
        //List<String> listOfEmailAddresses = new List<String>();  -> we used this one in line 28
        List<Messaging.SingleEmailMessage> messageList = new List<Messaging.SingleEmailMessage>();
        List<Lead> leadsToDelete = new List<Lead>();
        for (Lead ld : leads){
            if (ld.Email !=null && ld.Phone ==null ) {
                //leadsToSendEmail.add(ld); -> same reason with line 14
                //listOfEmailAddresses.add(ld.Email); -> same reason with line 15
                Messaging.SingleEmailMessage msg = new  Messaging.SingleEmailMessage();
                msg.setSubject('Update About Leads');
                msg.setPlainTextBody('Hey!' + ld.LastName + ' its an advertisement.');
                List<String> emailList = new List<String>{ld.Email};
                msg.setToAddresses(emailList);
                messageList.add(msg);
            } else if (ld.Email ==null && ld.Phone ==null ) {
                leadsToDelete.add(ld);
            }
            
        }
        delete leadsToDelete;
        Messaging.sendEmail(messageList);
        
    }
    public void finish(Database.BatchableContext bc){
        
    }
}
// LeadsCleaningBatch lcb = new LeadsCleaningBatch();
// database.executeBatch(lcb);