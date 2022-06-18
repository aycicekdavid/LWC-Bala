@isTest
public class CaseManagerTest {
	
    @TestSetup
    public static void testSetup() {
        //create accounts
        List<Account> accounts = TestSuite.createAccounts(2);
        insert accounts;
        
        //collect the ids of created accounts
        List<Id> accountIds = new List<Id>();
        for(Account acc : [SELECT Id FROM Account]) {
            accountIds.add(acc.Id);
        }
        
        //create cases
        List<Case> cases = TestSuite.createCases(accountIds);
        insert cases;
    }
    
    @isTest
    private static void getCaseTest() {
        //prepare rest request
        Test.startTest();
        Case cs = [SELECT Id FROM Case LIMIT 1];
        RestRequest request = new RestRequest();
        request.requestURI = 'https://sibatch6-dev-ed.lightning.force.com/services/apexrest/Case/'+cs.Id;
        request.httpMethod = 'GET';
        
        //prepare rest context
        RestContext.request = request;
        
        //make a call to the method
        Case csObj = CaseManager.getCase();
        
        //do asserts
        System.assert(csObj != null);
        Test.stopTest();
    }
    
    @isTest
    private static void postCaseTest() {
        Test.startTest();
        Id caseId = CaseManager.postCase('test subject', 'test description', 'Email');
        System.assertNotEquals(caseId, null);
        Test.stopTest();
    }
    
    @isTest
    private static void deleteCaseTest() {
        //prepare rest request
        Test.startTest();
        Case cs = [SELECT Id FROM Case LIMIT 1];
        RestRequest request = new RestRequest();
        request.requestURI = 'https://sibatch6-dev-ed.lightning.force.com/services/apexrest/Case/'+cs.Id;
        request.httpMethod = 'DELETE';
        
        //prepare rest context
        RestContext.request = request;
        
        //make a call to the method
        String actual = CaseManager.deleteCase();
        
        //do asserts
        System.assertEquals('The case has been deleted successfully', actual);
        Test.stopTest();
    }
    
    @isTest
    private static void putCaseTest() {
        Test.startTest();
        //prepare request body
        Case cs = new Case();
        cs.Subject = 'Test Subject';
        cs.Description = 'This is a test case';
        cs.Origin = 'Phone';
        String jsonString = JSON.serialize(cs);
        
        //prepare rest request
        RestRequest request = new RestRequest();
        request.httpMethod = 'PUT';
        request.requestBody = Blob.valueOf(jsonString);
        
        //prepare rest context
        RestContext.request = request;
        
        //make a call to the method
        Case csObj = CaseManager.putCase();
        
        //do asserts
        System.assertNotEquals(csObj, null);
        System.assertNotEquals(csObj.Id, null);
        Test.stopTest();
    }
    
    @isTest
    private static void patchCaseTest() {
        Test.startTest();
        //prepare request body
        Case cs = [SELECT Id, Subject, Description, Origin FROM Case LIMIT 1];
        String jsonString = JSON.serialize(cs);
        
        //prepare rest request
        RestRequest request = new RestRequest();
        request.httpMethod = 'PATCH';
        request.requestBody = Blob.valueOf(jsonString);
        
        //prepare rest context
        RestContext.request = request;
        
        //make a call to the method
        Case csObj = CaseManager.patchCase();
        
        //do asserts
        System.assertNotEquals(csObj, null);
        System.assertNotEquals(csObj.Id, null);
        Test.stopTest();
    }
}