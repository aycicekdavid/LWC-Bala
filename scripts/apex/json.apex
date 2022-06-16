//JSON Methods//

//JSON format
{
    "key1" : "value1",
    "key2" : "value2"
}

//serialize method
Account acc = [SELECT Id, Name, Type, Industry, AnnualRevenue 
                FROM Account 
                WHERE Industry != null 
                AND AnnualRevenue != null 
                LIMIT 1];
String jsonString = JSON.serialize(acc);
System.debug(jsonString);

List<Account> accounts = [SELECT Id, Name, Type, AnnualRevenue, Valid_Customer__c 
                        FROM Account LIMIT 5];
String jsonString = JSON.serialize(accounts);
System.debug(jsonString);


//deserialize method
String jsonString = '{"Name" : "Test Account 10", "Type" : "Prospect", "AnnualRevenue" : 123400}';
Account acc = (Account)JSON.deserialize(jsonString, Account.class);
insert acc;

//Get top 5 contacts whose last name is not blank and convert them into json string and print the same\
List<Contact> contacts = [SELECT Id, FirstName, LastName, Email 
                        FROM Contact
                        WHERE LastName != null
                        ORDER BY LastName ASC
                        LIMIT 5];
String jsonString = JSON.serialize(contacts);
System.debug(jsonString);

//Get Top 1 payment based on amount and convert the same into json string
Payment__c payment = [SELECT Id, Amount_Incurred__c, Payment_Type__c 
                    FROM Payment__c
                    ORDER BY Amount_Incurred__c DESC
                    LIMIT 1];
String jsonString = JSON.serialize(payment);
System.debug(jsonString);


<Account>
    <Name>Soft Innovas</Name>
    <Type>Prospect</Type>
    <Industry>Biotechnology</Industry>
</Account>


//Test RestCallouts//
RestCallouts.getAnimals();
RestCallouts.getUsers();
RestCallouts.postUsers();

//Test SoapCallouts//
SoapCallouts.getParks('India');

<?xml version="1.0" encoding="UTF-8"?>
<env:Envelope xmlns:env="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <env:Header />
    <env:Body>
        <m:byCountry xmlns:m="http://parks.services/">
            <arg0>United States</arg0>
        </m:byCountry>
    </env:Body>
</env:Envelope>

<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
    <soap:Body>
        <ns2:byCountryResponse xmlns:ns2="http://parks.services/">
            <return>Yellowstone</return>
            <return>Mackinac National Park</return>
            <return>Yosemite</return>
        </ns2:byCountryResponse>
    </soap:Body>
</soap:Envelope>