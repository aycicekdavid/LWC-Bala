public with sharing class AccountInvocable {
    @InvocableMethod(label='Delete Opportunities' 
    description='This method is going to delete all the opportunities for the given account id'
    category='Account')
    public static void deleteOpportunities(List<Id> accountIds) {
        Id accountId = accountIds[0];
        List<Opportunity> opps = [SELECT Id FROM Opportunity 
                                WHERE AccountId = :accountId
                                AND StageName IN ('Closed Won','Closed Lost')];
        delete opps;
    }
}