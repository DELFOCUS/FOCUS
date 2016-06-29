@isTest
public class TaxonomySearchCtrlTest{

    static testmethod void myUnitTest1(){
        Test.startTest();
        
        TaxonomySearchCtrl t = new TaxonomySearchCtrl();
        t.getDivisions();
        t.getStatus();
        t.getResidential();
        t.selectedDivision = 'DFS';
        t.Level1Code = '1234';
    	t.Level2Code = '1234';
        t.Level3Code = '1234';    
        t.Level1Desc = 'Level 1 Desc';
        t.Level2Serv = 'Lev 2 Serv';
        t.Level3SubServ = 'Sub Serv';
        t.HPC = 'efwe';
        t.Resident = 'Residential';
        t.serviceStat = 'Active';
        
        t.formatForList('DFS');
        t.getMatchingRecords();
		t.createNew();
        
        Test.stopTest();
    }
}