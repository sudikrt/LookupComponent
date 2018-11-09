@isTest
private class TestGenLookupCntl {


    @testSetup static void methodName() {
        List<Account> accList = new List<Account> ();
        
		accList.add (new Account (Name = 'Rajesh'));
       	accList.add (new Account (Name = 'Ramesh'));
       	accList.add (new Account (Name = 'Rakesh'));
        
        insert accList;
    }

    static testmethod void test_soql() {
        String searchString='Ra';
        String sObjectAPIName='Account';
        String fld_API_Text='Name';
        String fld_API_Val='Id';                                                    
        String fld_API_Search='Name';
        Integer limitVal=100; 
        Boolean isSOQL=true;
        String filter='';
        List<GenLookUpResult> results = GenLookupCntl.lookup(searchString, sObjectAPIName, fld_API_Text, 
                                                             fld_API_Val, fld_API_Search, limitVal, isSOQL, filter);
        System.assertEquals(3, results.size());
    }
    
    static testmethod void test_error() {
        String searchString='Ra';
        String sObjectAPIName='Acount';
        String fld_API_Text='Name';
        String fld_API_Val='Id';                                                    
        String fld_API_Search='Name';
        Integer limitVal=100; 
        Boolean isSOQL=true;
        String filter='';
        List<GenLookUpResult> results = GenLookupCntl.lookup(searchString, sObjectAPIName, fld_API_Text, 
                                                             fld_API_Val, fld_API_Search, limitVal, isSOQL, filter);
        System.assertEquals(0, results.size ());
    }
    
    static testmethod void test_sosl() {
        
        //https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_testing_SOSL.htm
        
        Id [] fixedSearchResults = new Id []{};
        for (Account a : [SELECT Id FROM Account LIMIT 100]) {
        	fixedSearchResults.add (a.Id);    
        }
        Test.setFixedSearchResults(fixedSearchResults);
        
        String searchString='Mahi';
        String sObjectAPIName='Account';
        String fld_API_Text='Name';
        String fld_API_Val='Id';                                                   
        String fld_API_Search='Name';
        Integer limitVal=100; 
        Boolean isSOQL=false;
        String filter='';
        List<GenLookUpResult> results = GenLookupCntl.lookup(searchString, sObjectAPIName, 
                                                             fld_API_Text, fld_API_Val, fld_API_Search, limitVal, isSOQL, filter);
    }
}