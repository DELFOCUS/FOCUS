@isTest
public class ProviderSearchController_Test {
     static testmethod void myUnitTest2(){
        Test.startTest();
        PageReference pg = Page.ProviderSearchPage;
		Test.setCurrentPage(pg);
        pg.getParameters().put('licType', 'test sold');
        pg.getParameters().put('licNumber', '12345');
		pg.getParameters().put('licEffFrom', '06/01/2016');
        pg.getParameters().put('licEffTill', '06/01/2016');
		pg.getParameters().put('licExpFrom', '06/01/2016');
        pg.getParameters().put('licExpTill', '06/01/2016');
		pg.getParameters().put('accType', 'Business');
        pg.getParameters().put('accEffFrom', '06/01/2016');
		pg.getParameters().put('accEffTill', '06/01/2016');
        pg.getParameters().put('accExpFrom', '06/01/2016');
		pg.getParameters().put('accExpTill', '06/01/2016');
        ProviderSearchController t = new ProviderSearchController();
        //t.newProvider();
		t.runSearch();
        t.GetAvailableRecordTypeNamesForSObject(Account.SObjectType);
        //t.runQuery();
        Test.stopTest();
    }
    
    
     static testmethod void myUnitTest4(){
        Test.startTest();
        PageReference pg = Page.ProviderSearchPage;
		Test.setCurrentPage(pg);
        
		pg.getParameters().put('accType', 'Business');
        pg.getParameters().put('accEffFrom', '06/01/2016');
		pg.getParameters().put('accEffTill', '06/01/2016');
        pg.getParameters().put('accExpFrom', '06/01/2016');
		pg.getParameters().put('accExpTill', '06/01/2016');
        ProviderSearchController t = new ProviderSearchController();
        t.newProvider();
		t.runSearch();
        t.GetAvailableRecordTypeNamesForSObject(Contact.SObjectType);
        //t.providerTypes = 'test';
        Test.stopTest();
    }
      static testmethod void myUnitTest3(){
        Test.startTest();
        PageReference pg = Page.ProviderSearchPage;
		Test.setCurrentPage(pg);
        pg.getParameters().put('licType', 'Business');
        pg.getParameters().put('licNumber', '123456');
		pg.getParameters().put('licEffFrom', '06/01/2016');
        pg.getParameters().put('licEffTill', '06/01/2016');
		pg.getParameters().put('licExpFrom', '06/01/2016');
        pg.getParameters().put('licExpTill', '06/01/2016');
		
        ProviderSearchController t = new ProviderSearchController();
        t.newProvider();
		t.runSearch();
        t.toggleSort();
        t.resetSOQL();
        
        t.debugSoql='';
        t.debugSoql2='';
        account acc=new account();
        t.getPickValues(acc,'dd_Emergency_Provider__c');
        //sObject s = new Account();

        //t.GetAvailableRecordTypeNamesForSObject(Account.SObjectType);
       // system.assertEquals(true, t.accTypeVal);
        Test.stopTest();
    }
   
 static testmethod void myUnitTest1(){
        Test.startTest();
        PageReference pg = Page.ProviderSearchPage;
		Test.setCurrentPage(pg);
     	pg.getParameters().put('firstName', 'test name');
		pg.getParameters().put('lastName', 'test sold');
        pg.getParameters().put('street', 'test name');
		pg.getParameters().put('city', 'test sold');
        pg.getParameters().put('emrPro', 'test name');
		pg.getParameters().put('gtf', 'test sold');
        pg.getParameters().put('refn', 'test name');
		pg.getParameters().put('city', 'test sold');
        pg.getParameters().put('refType', 'test name');
		pg.getParameters().put('state', 'test sold');
        pg.getParameters().put('zip', 'test name');
		pg.getParameters().put('apt', 'test sold');
        pg.getParameters().put('phone', 'test name');
		
     
        //ProviderSearchController1 t = new ProviderSearchController1();
        ////Test.setCurrentPageReference(new PageReference('Page.ProviderSearchPage1')); 
        //System.currentPageReference().getParameters().put('TestName', firstName);
        ProviderSearchController t = new ProviderSearchController();
        /*t.getEmrgncyProVal();
        t.getgtfLvl();pg.getParameters().put('accType', '');
        pg.getParameters().put('accEffFrom', 'test name');
		pg.getParameters().put('accEffTill', 'test sold');
        pg.getParameters().put('accExpFrom', 'test name');
		pg.getParameters().put('accExpTill', 'test sold');
        t.getrefTypeList(); 
        t.getlicTypeVal();
        t.getaccTypeVal(); 
        t.firstName = 'DFS';
        t.lastName = '1234';
    	t.street = '1234';
        t.city = '1234';    
        t.emrPro = 'Level 1 Desc';
        t.gtf = 'Lev 2 Serv';
        t.refn = 'Sub Serv';
        t.refType = 'efwe';
        t.state = 'Residential';
        t.zip = 'Active';
        t.apt = '500084' ;  */    
        
        t.newProvider();
		t.runSearch();
        
        Test.stopTest();
    }
}