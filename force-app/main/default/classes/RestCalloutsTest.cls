@isTest
public class RestCalloutsTest {

    @isTest
    private static void getAnimalsTest() {
        RestCalloutsMock mock = new RestCalloutsMock();
        Test.setMock(HttpCalloutMock.class, mock);
        HttpResponse response = RestCallouts.getAnimals();
        System.assertEquals(200, response.getStatusCode());
        System.assertEquals('OK', response.getStatus());
        String expected = '{"animals":["majestic badger","fluffy bunny","scary bear","chicken"]}';
        System.assertEquals(expected, response.getBody());
    }
}