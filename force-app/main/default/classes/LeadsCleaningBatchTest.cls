@isTest
public class LeadsCleaningBatchTest {
	@TestSetup
    private static void testSetup(){
        
        List<Lead> leads = new List<Lead>();
        leads.addAll(TestSuite.createEmailnoPhone(3));
       	leads.addAll(TestSuite.createBothNullLead(3));
        insert leads;
        System.assertEquals(6, [SELECT count() FROM Lead]);
    }    
    
    @isTest
    private static void testBatch(){
        test.startTest();
        LeadsCleaningBatch b = new LeadsCleaningBatch();
        Database.executeBatch(b, 50);
        test.stopTest();
      	System.assertEquals(3, [SELECT count() FROM Lead]);
    }
}