public with sharing class SoapCallouts {
    public static String[] getParks(String country) {
        ParksServices.ParksImplPort parkService = new ParksServices.ParksImplPort();
        String[] parks = parkService.byCountry(country);
        System.debug(parks);
        return parks;
    }
}