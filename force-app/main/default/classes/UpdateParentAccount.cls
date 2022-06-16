public with sharing class UpdateParentAccount implements Queueable {

    private List<Account> accounts = new List<Account>();
    private Id parentId;

    public UpdateParentAccount(List<Account> accs, Id parentId) {
        this.accounts = accs;
        this.parentId = parentId;
    }
    
    public void execute(QueueableContext qc) {
        for(Account acc : accounts) {
            acc.ParentId = parentId;
        }
        update accounts;
    }

}

//Invoke Queueable Apex//
/*
Account parentAccount = [SELECT Id FROM Account WHERE Name = 'Soft Innovas' LIMIT 1];
List<Account> accounts = [SELECT Id, ParentId FROM Account WHERE ParentId != null AND Name != 'Soft Innovas'];
UpdateParentAccount upa = new UpdateParentAccount(accounts, parentAccount.Id);
System.enqueueJob(upa);
*/