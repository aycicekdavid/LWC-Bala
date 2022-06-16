@RestResource(urlMapping='/Case/*')
global class CaseManager {
    
    @HttpGet
    global static Case getCase() {
        RestRequest req = RestContext.request;
        String url = req.requestURI;
        Integer lastIndex = url.lastIndexOf('/');
        String caseId = url.subString(lastIndex+1);
        List<Case> cases = [SELECT Id, CaseNumber, Status, Priority FROM Case WHERE Id = :caseId];
        if(!cases.isEmpty()) {
            return cases[0];
        } else {
            throw new CustomException('Invalid case id. Please send a valid case id in order to get information!');
        }
    }

    /*
    {
        "subject" : "Test Case",
        "description" : "Test Desc",
        "origin" : "Web"
    }
    */
    @HttpPost
    global static Id postCase(String subject, String description, String origin) {
        Case cs = new Case();
        cs.Subject = subject;
        cs.Description = description;
        cs.Origin = origin;
        cs.Priority = 'Medium';
        cs.Status = 'New';
        insert cs;
        return cs.Id;
    }

    @HttpDelete
    global static String deleteCase() {
        RestRequest req = RestContext.request;
        String url = req.requestURI;
        String caseId = url.subString(url.length()-18);
        List<Case> cases = [SELECT Id FROM Case WHERE Id = :caseId];
        if(!cases.isEmpty()) {
            delete cases;
            return 'The case has been deleted successfully';
        } else {
            throw new CustomException('Couldnt find any cases with the supllied case id');
        }
    }

    @HttpPut
    global static Case putCase() {
        RestRequest req = RestContext.request;
        String jsonString = req.requestBody.toString();
        Case cs = (Case)JSON.deserialize(jsonString, Case.class);
        upsert cs;
        List<Case> cases =[SELECT Id, CaseNumber, Subject, Priority FROM Case WHERE Id = :cs.Id];
        return cases[0];
    }

    @HttpPatch
    global static Case patchCase() {
        RestRequest req = RestContext.request;
        String jsonString = req.requestBody.toString();
        Map<String, Object> caseInfo = (Map<String, Object>)JSON.deserializeUntyped(jsonString);
        Case cs = new Case();
        for(String key : caseInfo.keySet()) {
            cs.put(key, caseInfo.get(key));
        }
        update cs;
        List<Case> cases =[SELECT Id, CaseNumber, Subject, Priority FROM Case WHERE Id = :cs.Id];
        return cases[0];
    }

}

/*
//https://sibatch6-dev-ed.lightning.force.com/services/apexrest/Case/5005j00000KctdcAAB;
urlParts = [
0    https:
1     
2    sibatch6-dev-ed.lightning.force.com
3    services
4    apexrest
5    Case
6    5005j00000KctdcAAB
]
7-1=6


Case cs = new Case();
cs.Subject = 'Test Subject';
cs.Priority = 'high';
update cs;

Case cs = new Case();
cs.put('Subject', 'Test Subject');
cs.put('Priority', 'High');
update cs;
*/