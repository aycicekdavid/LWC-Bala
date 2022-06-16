public with sharing class RestCallouts {

    private static final String GET_ANIMALS = 'Get_Animals';
    private static final String GET_USERS = 'Get_Users';
    private static final String POST_ANIMALS = 'Post_Animals';
    private static final String POST_ACCOUNTS = 'Post_Accounts';
    private static final String POST_USERS = 'Post_Users';

    private static final String HTTP_METHOD_GET = 'GET';
    private static final String HTTP_METHOD_POST = 'POST';

    private static final String LOG_ERROR = 'Error';
    private static final String LOG_CALLOUT = 'Callout';
    
    public static HttpResponse getAnimals() {
        //1. prepare a request
        HttpRequest request = new HttpRequest();
        request.setEndpoint(CustomMetadataHelper.getEndpoint(GET_ANIMALS));
        request.setMethod(HTTP_METHOD_GET);

        //2. prepare internet
        Http http = new Http();

        //3. send the request over the internet
        HttpResponse response = http.send(request);

        //4. process the response
        if(response.getStatusCode() == 200) {
            String jsonString = response.getBody();
            System.debug(jsonString);
            Map<String, Object> info = (Map<String, Object>)JSON.deserializeUntyped(jsonString);
            //map(key="animals", value=Object)
            List<Object> animals = (List<Object>)info.get('animals');
            for(Object obj : animals) {
                System.debug(obj);
            }
        } else {
            //log an error
            CommonUtility.createLog(LOG_ERROR, LOG_CALLOUT, 'getAnimals', response.getBody());
        }
        return response;
    }

    public static HttpResponse getUsers() {
        //1. prepare a request
        HttpRequest request = new HttpRequest();
        request.setEndpoint(CustomMetadataHelper.getEndpoint(GET_USERS));
        request.setMethod(HTTP_METHOD_GET);

        //2. prepare internet
        Http internet = new Http();

        //3. send the request over the internet
        HttpResponse response = internet.send(request);

        //4. process the response
        if(response.getStatusCode() == 200) {
            String jsonString = response.getBody();
            System.debug(jsonString);
            List<UserResponse> users = (List<UserResponse>)JSON.deserialize(jsonString, List<UserResponse>.class);
            System.debug(users);
            processUserResponse(users);
        } else {
            //log an error
            CommonUtility.createLog(LOG_ERROR, LOG_CALLOUT, 'getUsers', response.getBody());
        }
        return response;
    }

    public static void processUserResponse(List<UserResponse> userResponses) {
        Set<String> names = new Set<String>();
        Map<String, Contact> contacts = new Map<String, Contact>();
        List<Contact> contactsToUpdate = new List<Contact>();
        for(UserResponse ur : userResponses) {
            names.add(ur.name);
        }
        for(Contact con : [SELECT Name, Gender__c, Status__c, Email FROM Contact WHERE Name IN :names]) {
            contacts.put(con.Name, con);
        }
        for(UserResponse response : userResponses) {
            if(contacts.containsKey(response.name)) {
                Contact con = contacts.get(response.name);
                con.Email = response.email;
                con.Gender__c = response.gender;
                con.Status__c = response.status;
                contactsToUpdate.add(con);
            }
        }
        update contactsToUpdate;
    }

    public static HttpResponse postAnimals() {
        //1. prepare request
        HttpRequest request = new HttpRequest();
        request.setEndpoint(CustomMetadataHelper.getEndpoint(POST_ANIMALS));
        request.setMethod(HTTP_METHOD_POST);
        String body = '{"animal" : "fluffy bunny"}';
        request.setBody(body);
        request.setHeader('Content-Type', 'application/json');

        //2. prepare http
        Http http = new Http();

        //3. send request over http and receive response
        HttpResponse response = http.send(request);

        //4. process the response
        if(response.getStatusCode() == 201) {
            //everything went smooth
        } else {
            //log an error
            CommonUtility.createLog(LOG_ERROR, LOG_CALLOUT, 'postAnimals', response.getBody());
        }
        return response;
    }

    /**
     * All the accounts created in our system have to be sent to client's inhouse system
     */
    public static HttpResponse postAccounts() {
        //1. prepare request
        HttpRequest request = new HttpRequest();
        request.setEndpoint(CustomMetadataHelper.getEndpoint(POST_ACCOUNTS));
        request.setMethod(HTTP_METHOD_POST);

        List<Account> accounts = [SELECT Name, Type, Industry, AnnualRevenue 
                                FROM Account 
                                WHERE CreatedDate = TODAY
                                AND Is_Sent__c = false];
        String jsonString = JSON.serialize(accounts);
        request.setBody(jsonString);
        request.setHeader('Content-Type', 'application/json');

        //2. prepare http
        Http internet = new Http();

        //3. send the request over the internet and receive the response
        HttpResponse response = internet.send(request);

        //4. process the response
        if(response.getStatusCode() == 201) {
            for(Account acc : accounts) {
                acc.Is_Sent__c = true;
            }
            update accounts;
        } else {
            //log an error
            CommonUtility.createLog(LOG_ERROR, LOG_CALLOUT, 'postAccounts', response.getBody());
        }
        return response;
    }

    public static HttpResponse postUsers() {
        HttpRequest request=new HttpRequest();
        request.setEndpoint(CustomMetadataHelper.getEndpoint(POST_USERS));
        request.setMethod(HTTP_METHOD_POST);
       // String body='{"name": "morpheus" , "job" : "leader"}';
        Contact con=[SELECT Name, Department 
                    FROM Contact
                    ORDER BY LastModifiedDate DESC
                    LIMIT 1];
        contactRequest cr=new contactRequest();
        cr.name=con.Name;
        cr.job=con.Department;
        request.setBody(JSON.serialize(cr));
        request.setHeader('Content-Type', 'application/json');

        Http internet= new Http();
        HttpResponse response=internet.send(request);
        if(response.getStatusCode() == 201){
            con.Data_Send_On__c=Datetime.now();
            update con;
        } else {
            CommonUtility.createLog(LOG_ERROR, LOG_CALLOUT, 'postContact', response.getBody());
        }

        return response;

    }
    public class contactRequest{
        public String name;
        public String job;
    }

    public static HttpResponse getAnimalsWithAuthorization() {
        //1. prepare a request
        HttpRequest request = new HttpRequest();
        request.setEndpoint(CustomMetadataHelper.getEndpoint(GET_ANIMALS));
        request.setMethod(HTTP_METHOD_GET);

        //extra: authorization
        String username = 'balakrishna.ette@softinnovas.com';
        String password = 'Test@123'; 
        Blob requestBlob = Blob.valueOf(username + ':' + password); //balakrishna.ette@softinnovas.com:Test@123
        String authorisationString = 'BASIC ' + EncodingUtil.base64Encode(requestBlob);
        request.setHeader('Authorization', authorisationString);

        //2. prepare internet
        Http http = new Http();

        //3. send the request over the internet
        HttpResponse response = http.send(request);

        //4. process the response
        if(response.getStatusCode() == 200) {
            String jsonString = response.getBody();
            System.debug(jsonString);
            Map<String, Object> info = (Map<String, Object>)JSON.deserializeUntyped(jsonString);
            //map(key="animals", value=Object)
            List<Object> animals = (List<Object>)info.get('animals');
            for(Object obj : animals) {
                System.debug(obj);
            }
        } else {
            //log an error
            CommonUtility.createLog(LOG_ERROR, LOG_CALLOUT, 'getAnimals', response.getBody());
        }
        return response;
    }

}