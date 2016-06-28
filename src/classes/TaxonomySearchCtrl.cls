public class TaxonomySearchCtrl{

    public List<DD_Service_Taxonomy__c> serviceTaxonomies {get;set;}
    public String ProviderId {get;set;}
    public String searchQuery{get;set;}
    public String selectedDivision { get;set;}
    public String Level1Code {get;set;}
    public String Level2Code {get;set;}
    public String Level3Code {get;set;}    
    public String Level1Desc {get;set;}
    public String Level2Serv {get;set;}
    public String Level3SubServ {get;set;}
    public String HPC {get;set;}
    public String Resident {get;set;}
    public String serviceStat {get;set;}
    public String ShowResults{get;set;}

    public TaxonomySearchCtrl(){
        serviceTaxonomies = new List<DD_Service_Taxonomy__c>();
        ProviderId = ApexPages.currentPage().getParameters().get('providerId');
        ShowResults = '';
    }

    public List<SelectOption> getDivisions(){
        List<SelectOption> options = new List<SelectOption>();        
        Schema.DescribeFieldResult fieldResult = DD_Service_Taxonomy__c.DD_Division__c.getDescribe();
        options.add(new SelectOption('None', '--None--'));       
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();        
        for( Schema.PicklistEntry f : ple){
          options.add(new SelectOption(f.getLabel(), f.getValue()));
        }       
       return options;
    }

    public List<SelectOption> getStatus(){
        List<SelectOption> options = new List<SelectOption>();        
        Schema.DescribeFieldResult fieldResult = DD_Service_Taxonomy__c.DD_Service_Status__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues(); 
        options.add(new SelectOption('None', '--None--'));       
        for( Schema.PicklistEntry f : ple){
          options.add(new SelectOption(f.getLabel(), f.getValue()));
        }       
       return options;
    }

    public List<SelectOption> getResidential(){
        List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('None', '--None--'));              
        Schema.DescribeFieldResult fieldResult = DD_Service_Taxonomy__c.DD_Residential_Status__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();        
        for( Schema.PicklistEntry f : ple){
          options.add(new SelectOption(f.getLabel(), f.getValue()));
        }       
       return options;
    }
        
    public PageReference getMatchingRecords(){         
         system.debug('\n\n Level1Code - ' + Level1Code + '\n\n Level2Code - ' + Level2Code + '\n\n Level3Code - '+ Level3Code + 
                 '\n\n Level1Desc -' + Level1Desc + '\n\n Level2Serv - ' + Level2Serv + '\n\n Level3SubServ - '+ Level3SubServ);
        system.debug('\n\n HPC - ' + HPC + '\n\n Resident - ' + Resident + '\n\n serviceStat - '+ serviceStat + 
                 '\n\n selectedDivision -' + selectedDivision);                 
         
         searchQuery               = 'SELECT id, DD_Adoption_Status__c, DD_Contract_Details__c, DD_Conversion_Divisions__c, DD_Conv_Residential_Status__c, '+
                                            ' DD_Division__c, DD_Foster_Care_Setting_Type__c, DD_Health_Procedure_Codes__c, DD_Reimbursable_Payment__c, DD_Level_1__c, '+
                                            ' DD_Level_1_Code__c, DD_Level_2__c, DD_Level_2_Code__c, DD_Level_3__c, DD_Level_3_Code__c, DD_MA_Service__c, '+
                                            ' DD_Paid_Status__c, DD_Residential_Status__c, DD_Service_Status__c '+
                                      ' FROM DD_Service_Taxonomy__c ' ;
        if((!String.isEmpty(Level1Code) && !Level1Code.isNumeric()) || (!String.isEmpty(Level2Code) && !Level2Code.isNumeric()) || (!String.isEmpty(Level3Code) && !Level3Code.isNumeric())){
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.Error, Label.OnlyNumeric);
            ApexPages.addMessage(msg);
            return null;
        }
                              
        if(!String.isEmpty(Level1Code) || !String.isEmpty(Level2Code) || !String.isEmpty(Level3Code) || !String.isEmpty(Level1Desc) 
                || !String.isEmpty(Level2Serv) || !String.isEmpty(Level3SubServ) || !String.isEmpty(HPC) 
                || (!String.isEmpty(selectedDivision) && selectedDivision != 'None') || (!String.isEmpty(Resident) && Resident != 'None') || (!String.isEmpty(serviceStat) && serviceStat != 'None')){
            searchQuery = searchQuery + ' WHERE ';
        } 
        if(!String.isEmpty(Level1Code)){
            searchQuery = searchQuery + ' DD_Level_1_Code__c = '+ Integer.valueOF(Level1Code) +' AND ';
        }
        if(!String.isEmpty(Level2Code)){
            searchQuery = searchQuery + ' DD_Level_2_Code__c = '+ Integer.valueOF(Level2Code) +' AND ';
        }
        if(!String.isEmpty(Level3Code)){
            searchQuery = searchQuery + ' DD_Level_3_Code__c = '+ Integer.valueOF(Level3Code) +' AND ';
        }
        if(!String.isEmpty(Level1Desc)){
            searchQuery = searchQuery + ' DD_Level_1__c = \''+ Level1Desc +'\' AND ';
        }
        if(!String.isEmpty(Level2Serv)){
            searchQuery = searchQuery + ' DD_Level_2__c = \''+ Level2Serv +'\' AND ';
        }
        if(!String.isEmpty(Level3SubServ)){
            searchQuery = searchQuery + ' DD_Level_3__c = \''+ Level3SubServ +'\' AND ';
        }

        if(!String.isEmpty(Level3SubServ)){
            searchQuery = searchQuery + ' DD_Level_3__c = \''+ Level3SubServ +'\' AND ';
        }

        if(!String.isEmpty(HPC)){
            searchQuery = searchQuery + ' DD_Health_Procedure_Codes__c = \''+ HPC +'\' AND ';
        }

        if(!String.isEmpty(selectedDivision) && selectedDivision != 'None'){
            searchQuery = searchQuery + ' DD_Division__c INCLUDES ' + formatForList(selectedDivision) + ' AND ';
        }

        if(!String.isEmpty(Resident) && Resident != 'None'){
            searchQuery = searchQuery + ' DD_Residential_Status__c = \''+ Resident +'\' AND ';
        }

        if(!String.isEmpty(serviceStat) && serviceStat != 'None'){
            searchQuery = searchQuery + ' DD_Service_Status__c =\''+ serviceStat +'\' AND ';
        }
        
        if(searchQuery.endsWith('AND ')){
            searchQuery = searchQuery.substring(0, searchQuery.length() - 4);
        }

        system.debug('\n searchQuery: ' + searchQuery);
        serviceTaxonomies = Database.Query(searchQuery);
        if(serviceTaxonomies.Size() > 0){
            ShowResults = 'Yes';
        }else{
            ShowResults = 'No';
        }
        system.debug('\n\n ShowResults : ' + ShowResults );
        return null;
    }

    public string formatForList (List<string> qList){
        string qCond = '(';
        for(string str : qList){
            str = string.escapeSingleQuotes(str);
            qCond = qCond + '\''+str +'\',';
        }
        qCond = qCond.substring(0,qCond.length() - 1) + ')';
        
        return qCond;       
    }

    public string formatForList (string field){
        List<string> tempList = new List<string>();
        tempList.add(field);
        return formatForList(tempList);       
    }

    public PageReference createNew(){
        Schema.DescribeSObjectResult r = DD_Service_Taxonomy__c.sObjectType.getDescribe();
        String keyPrefix = r.getKeyPrefix();
        system.debug('\n keyPrefix - ' + keyPrefix);
        PageReference pr = new PageReference('/'+ keyPrefix + '/e');
        pr.setRedirect(true);
        return pr;
    }
}