public with sharing class CaseInvocable {
    
    @InvocableMethod(label='Send Email & Save as Activity'
    description='Sends an email with the given input data and save the same as activity'
    category='Case')
    public static void sendEmail(List<FlowRequest> requests) {
        FlowRequest request = requests[0];
        List<Messaging.SingleEmailMessage> messages = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage msg = new Messaging.SingleEmailMessage();
        msg.setTargetObjectId(request.contactId);
        msg.setSubject('Your case has been received: '+request.caseNumber);
        msg.setPlainTextBody('Hello there, your case has been received. Stay tuned for further updates!');
        msg.setSaveAsActivity(true);
        messages.add(msg);
        Messaging.sendEmail(messages);
    }

    public class FlowRequest {
        @InvocableVariable(label='Contact Id' description='Contact Id' required=true)
        public Id contactId;

        @InvocableVariable(label='Case Number' description='Case Number' required=true)
        public String caseNumber;
    }
}