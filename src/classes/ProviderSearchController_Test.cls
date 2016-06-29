@isTest
public class ProviderSearchController_Test {
     static testmethod void myUnitTest4(){
        Test.startTest();
        PageReference pg = Page.ProviderSearchPage;
		Test.setCurrentPage(pg);
        pg.getParameters().put('licType', 'acc license');
        pg.getParameters().put('licNumber', '123456');
		pg.getParameters().put('licEffFrom', 'test sold');
        pg.getParameters().put('licEffTill', 'test name');
		pg.getParameters().put('licExpFrom', 'test sold');
        pg.getParameters().put('licExpTill', 'test name');
		pg.getParameters().put('accType', '');
        pg.getParameters().put('accEffFrom', 'test name');
		pg.getParameters().put('accEffTill', 'test sold');
        pg.getParameters().put('accExpFrom', 'test name');
		pg.getParameters().put('accExpTill', 'test sold');
        ProviderSearchController t = new ProviderSearchController();
        t.newProvider();
		t.runSearch();
        
        Test.stopTest();
    }
    static testmethod void myUnitTest3(){
        Test.startTest();
        PageReference pg = Page.ProviderSearchPage;
		Test.setCurrentPage(pg);
        pg.getParameters().put('licType', '');
        pg.getParameters().put('licNumber', '');
		pg.getParameters().put('licEffFrom', 'test sold');
        pg.getParameters().put('licEffTill', 'test name');
		pg.getParameters().put('licExpFrom', 'test sold');
        pg.getParameters().put('licExpTill', 'test name');
		pg.getParameters().put('accType', '');
        pg.getParameters().put('accEffFrom', 'test name');
		pg.getParameters().put('accEffTill', 'test sold');
        pg.getParameters().put('accExpFrom', 'test name');
		pg.getParameters().put('accExpTill', 'test sold');
        ProviderSearchController t = new ProviderSearchController();
        t.newProvider();
		t.runSearch();
        account acc=new account();
        t.getPickValues(acc,'dd_Emergency_Provider__c');
       // system.assertEquals(true, t.accTypeVal);
        Test.stopTest();
    }
    static testmethod void myUnitTest2(){
        Test.startTest();
        PageReference pg = Page.ProviderSearchPage;
		Test.setCurrentPage(pg);
        pg.getParameters().put('licType', 'test sold');
        pg.getParameters().put('licNumber', 'test name');
		pg.getParameters().put('licEffFrom', 'test sold');
        pg.getParameters().put('licEffTill', 'test name');
		pg.getParameters().put('licExpFrom', 'test sold');
        pg.getParameters().put('licExpTill', 'test name');
		pg.getParameters().put('accType', 'test sold');
        pg.getParameters().put('accEffFrom', 'test name');
		pg.getParameters().put('accEffTill', 'test sold');
        pg.getParameters().put('accExpFrom', 'test name');
		pg.getParameters().put('accExpTill', 'test sold');
        ProviderSearchController t = new ProviderSearchController();
        t.newProvider();
		t.runSearch();
        
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
        t.getgtfLvl();
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
        t.apt = '500084' ;   */    
        
        t.newProvider();
		t.runSearch();
        
        Test.stopTest();
    }
}