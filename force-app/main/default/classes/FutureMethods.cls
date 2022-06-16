public with sharing class FutureMethods {
    
    @future
    public static void sendEmailMessages(List<Id> contactIds) {
        List<Contact> contacts = [SELECT Id, LastName, Email FROM Contact WHERE Id IN :contactIds];
        List<Messaging.SingleEmailMessage> msgs = new List<Messaging.SingleEmailMessage>();
        for(Contact con : contacts) {
            String body = 'Hi ' + con.LastName + ', \n\n'
                + 'A contact has been created for you. Please quote your email when you call us next time. \n\n'
                + 'Thank you, \n'
                + 'Salesforce';
            Messaging.SingleEmailMessage msg = new Messaging.SingleEmailMessage();
            msg.setSubject('We are happy to have you in!');
            msg.setPlainTextBody(body);
            msg.setToAddresses(new List<String>{con.Email});
            msgs.add(msg);
        }
        Messaging.sendEmail(msgs);
    }
}