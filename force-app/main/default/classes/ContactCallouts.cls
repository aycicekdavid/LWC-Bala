public class ContactCallouts {
	@future(callout=true)
    public static void sendData(List<Id> contactIds) {
        //get the data and prepare json
        List<Contact> con = [Select Name, Email, Gender__c, Status__c FROM Contact WHERE Id = :contactIds[0]];
        UserInfo info = new UserInfo();
        //populate info with details from soql
        info.name = con[0].Name;
        info.email = con[0].Email;
        info.gender = con[0].Gender__c;
        info.status = con[0].Status__c;
        String jsonString = JSON.serialize(info);
        System.debug(jsonString);
        
        //prepare request
        String endpoint = 'https://gorest.co.in/public/v2/users';
        String token = '70e1f461fd475135683473e734663791d988ca49336b3a1002405be2ff00ed29';
        HttpRequest request = new HttpRequest();
        //set endpoint, httpmethod & request body
        request.setEndpoint(endpoint);
        request.setMethod('POST');
        request.setBody(jsonString);
        request.setHeader('Content-Type', 'application/json; charset=utf-8');
        request.setHeader('Authorization', 'Bearer 70e1f461fd475135683473e734663791d988ca49336b3a1002405be2ff00ed29');
        
        Http http = new Http();
        HttpResponse response = http.send(request);
        System.debug('Status Code: ' + response.getStatusCode());
        System.debug('Response: ' + response.getBody());
		//create a log => it can be info incase of sucess, error incase of error
		Application_Log__c log = new Application_Log__c();
        log.Target_Name__c = 'ContactCallouts';
        log.Target_Type__c = 'Integration';
        if(response.getStatusCode() == 201) {
            log.Status__c = 'Success';
            log.Message__c = response.getBody();
        } else {
            log.Status__c = 'Error';
            log.Message__c = response.getBody();
        }
		insert log;
    }
}