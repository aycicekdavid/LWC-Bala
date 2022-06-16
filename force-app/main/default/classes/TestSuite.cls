public class TestSuite {

    public static List<Account> createAccounts(Integer count) {
        List<Account> accounts = new List<Account>();
        for(Integer i=0; i<count; i++) {
            Account acc = new Account();
            acc.Name = 'Test Account ' + i;
            acc.Type = 'Prospect';
            acc.Industry = 'Biotechnology';  
            acc.AccountNumber = 'ACC123456';
            acc.Phone = '9912399123';
            acc.Rating = 'Cold';
            accounts.add(acc);
        }
        return accounts;
    }
    
    public static List<Case> createCases(List<Id> accountIds) {
        List<Case> cases = new List<Case>();
        for(Id accId : accountIds) {
            Case cs = new Case();
            cs.AccountId = accId;
            cs.Subject = 'Test Subject';
            cs.Priority = 'Low';
            cs.Status = 'New';
            cases.add(cs);
        }
        return cases;
    }
    
    public static List<Contact> getContacts(List<Id> accountIds) {
        List<Contact> contacts = new List<Contact>();
        for(Id accId : accountIds) {
            Contact con = new Contact();
            con.FirstName = 'Test';
            con.LastName = 'LstName';
            con.Email = 'test@test.com';
            con.AccountId = accId;
            contacts.add(con);
        }
        return contacts;
    }

    public static List<Payment__c> getInvalidPayments(Integer count) {
        List<Payment__c> payments = new List<Payment__c>();
        for(Integer i=0; i<count; i++) {
            Payment__c pay = new Payment__c();            
            if(i==0) {
            	pay.Payment_Type__c = 'Internet Allowance';
                pay.Amount_Incurred__c = null;
                pay.Currency_Incurred_In__c = 'AUD';
            } else {
                pay.Payment_Type__c = 'Well Being Allowance';
                pay.Amount_Incurred__c = 100.00;
                pay.Currency_Incurred_In__c = null;
            }
            payments.add(pay);
        }
        return payments;
    }
    
    public static List<Payment__c> getValidPayments(Integer count) {
        List<Payment__c> payments = new List<Payment__c>();
        for(Integer i=0; i<count; i++) {
            Payment__c pay = new Payment__c();            
            if(i==0) {
            	pay.Payment_Type__c = 'Internet Allowance';
                pay.Amount_Incurred__c = 150;
                pay.Currency_Incurred_In__c = 'AUD';
                pay.Payment_Status__c = 'Submitted';
            } else {
                pay.Payment_Type__c = 'Well Being Allowance';
                pay.Amount_Incurred__c = 100.00;
                pay.Currency_Incurred_In__c = 'AED';
                pay.Payment_Status__c = 'Submitted';
            }
            payments.add(pay);
        }
        return payments;
    }
    
    public static List<Allowance__c> getValidAllowances(Integer count) {
        List<Allowance__c> allowances = new List<Allowance__c>();
        for(Integer i=0; i<count; i++) {
            Allowance__c al = new Allowance__c();
            if(i == 0) {
                al.Allowance_Type__c = 'Internet Allowance';
                al.Amount__c = 500.00;
                al.Status__c = 'Submitted';
            } else {
                al.Allowance_Type__c = 'Hybrid Work Allowance';
                al.Amount__c = 5000.00;
                al.Status__c = 'Submitted';
            }
            allowances.add(al);
        }
        return allowances;
    }
    
    public static List<Allowance__c> getInvalidAllowances(Integer count) {
        List<Allowance__c> allowances = new List<Allowance__c>();
        for(Integer i=0; i<count; i++) {
            Allowance__c al = new Allowance__c();
            if(i == 0) {
                al.Allowance_Type__c = 'Internet Allowance';
                al.Amount__c = 5000.00;
                al.Status__c = 'Submitted';
            } else {
                al.Allowance_Type__c = 'Hybrid Work Allowance';
                al.Amount__c = 50000.00;
                al.Status__c = 'Submitted';
            }
            allowances.add(al);
        }
        return allowances;
    }
    
    public static List<Lead> createEmailnoPhone(Integer count){
        List<Lead> leads = new List<Lead>();
        for(Integer i=0; i < count; i++){
            Lead l = new Lead();
            l.LastName = 'Eagle';
            l.Company = 'Cold Inc';
            l.Email = 'faruk2820@gmail.com';
            
            leads.add(l);
        }
        return leads;
    }
    
    public static List<Lead> createbothNullLead(Integer count){
        List<Lead> leads = new List<Lead>();
        for(Integer i=0; i < count; i++){
            Lead l = new Lead();
            l.LastName = 'Eagle';
            l.Company = 'Cold Inc';
            leads.add(l);
        }
        return leads;
    }
    
}