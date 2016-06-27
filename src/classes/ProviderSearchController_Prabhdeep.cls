public with sharing class ProviderSearchController_Prabhdeep {

  private String soql {get;set;}
  private String soql2 {get;set;}
  
  public List<account> providers {get;set;}
  public List<account> providers2 {get;set;}
    

  public String sortDir {
    get  { if (sortDir == null) {  sortDir = 'asc'; } return sortDir;  }
    set;
  }
  
  public String sortField {
    get  { if (sortField == null) {sortField = 'dd_Last_name__c'; } return sortField;  }
    set;
  }
  
  public String debugSoql {
    get { return soql + ' order by ' + sortField + ' ' + sortDir + ' limit 10'; }
    set;
  }
  public String debugSoql2 {
    get { return soql2;}
    set;
  }
   
  public ProviderSearchController_Prabhdeep() {
    soql = label.ProviderSearchSOQL;
    soql2 = 'SOQL';//label.ProviderSearchSOQL;
    runQuery();
  }
   
  public void toggleSort() {
   
    sortDir = sortDir.equals('asc') ? 'desc' : 'asc';
    
    runQuery();
  }
 
  public void runQuery() {

    try {
        system.debug('soql>>>'+soql);  
        String duplicate;
      providers = Database.query(soql + ' order by ' + sortField + ' ' + sortDir + ' limit 20');
        if(!soql2.equals('SOQL')){
            providers2 = Database.query(soql2 + ' order by ' + sortField + ' ' + sortDir + ' limit 20');
            providers.addall(providers2);
            system.debug('fullProvider>>>>>>>>>>>'+providers.size());
              Set<account> myset = new Set<account>();
              for (account acc : providers){
                  for (account acc2 : myset){
                      if (acc2.get('Id') == acc.get('Id'))
                          duplicate = 'True';
                      }
                  system.debug('ProviderId>>>>>>>>>>>'+acc.get('Id'));
                  if(!duplicate.equals('True'))
                  myset.add(acc);
                  duplicate = 'False';
                  system.debug('myset>>>>>>>>>>>'+myset.size());
              }
              /*myset.addAll(providers);
              system.debug('myset>>>>>>>>>>>'+myset.size());
              providers.clear();
              system.debug('clearProvider>>>>>>>>>>>'+providers.size());
              providers.addAll(myset);
              system.debug('dataProvider>>>>>>>>>>>'+providers.size());
              */

        }
        system.debug('Providers >>>'+providers);
    } catch (Exception e) {
      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Ooops!'));
    }

  }
 
  public PageReference runSearch() {

    String firstName = Apexpages.currentPage().getParameters().get('firstname');
    String lastName = Apexpages.currentPage().getParameters().get('lastname');
    String street = Apexpages.currentPage().getParameters().get('street');
    String city = Apexpages.currentPage().getParameters().get('city');
    String emrPro = Apexpages.currentPage().getParameters().get('emrPro');
    String gtf = Apexpages.currentPage().getParameters().get('gtf');
    String refn = Apexpages.currentPage().getParameters().get('refn');
    String refType = Apexpages.currentPage().getParameters().get('refType');
      system.debug('refn>>'+Apexpages.currentPage().getParameters().get('refn'));
    //Benny
      String licType = Apexpages.currentPage().getParameters().get('licType');
      String licNumber = Apexpages.currentPage().getParameters().get('licNumber');
      String licEffFrom = Apexpages.currentPage().getParameters().get('licEffFrom');
      //Date licEffFrom = date.parse(Apexpages.currentPage().getParameters().get('licEffFrom'));
      String licEffTill = Apexpages.currentPage().getParameters().get('licEffTill'); 
      String licExpFrom = Apexpages.currentPage().getParameters().get('licExpFrom'); 
      String licExpTill = Apexpages.currentPage().getParameters().get('licExpTill'); 
      String accType = Apexpages.currentPage().getParameters().get('accType'); 
      String accEffFrom = Apexpages.currentPage().getParameters().get('accEffFrom'); 
      String accEffTill = Apexpages.currentPage().getParameters().get('accEffTill'); 
      String accExpFrom = Apexpages.currentPage().getParameters().get('accExpFrom'); 
      String accExpTill = Apexpages.currentPage().getParameters().get('accExpTill'); 
       
    //Benny
      system.debug('licType>>'+Apexpages.currentPage().getParameters().get('licType'));
      system.debug('licEffFrom >>>>>>'+Apexpages.currentPage().getParameters().get('licEffFrom'));
      system.debug('licEffFrom >>>>>>'+Apexpages.currentPage().getParameters().get('licEffFrom'));
      
      
    if(!refn.equals('') ){
       soql =label.ProviderSearchSOQL+' and id in (select DD_Provider__c from dd_Alternate_References__c where dd_Provider__c != null';   
        if (!refn.equals(''))
          soql += ' and dd_Reference_Number__c LIKE \'%'+String.escapeSingleQuotes(refn)+'%\'';
        if (!refType.equals(''))
          soql +=  ' and dd_Reference_Type__c LIKE \'%'+String.escapeSingleQuotes(refType)+'%\'';  
        soql += ') ';
        system.debug('reference number SOQL'+soql);
      }
   
    
      if(!street.equals('') || !city.equals('')){
       soql =label.ProviderSearchSOQL+' and id in (select dd_Provider__c from dd_Address__c where dd_Provider__c != null';
        if (!street.equals(''))
          soql += ' and Name LIKE \'%'+String.escapeSingleQuotes(street)+'%\'';
        if (!city.equals(''))
          soql +=  ' and dd_City__c LIKE \'%'+String.escapeSingleQuotes(city)+'%\'';  
        soql += ') ';
      }
    
      else if(!firstName.equals('') || !lastName.equals('') || !emrPro.equals('')){
        
        soql =label.ProviderSearchSOQL;
        if (!firstName.equals(''))
          soql += ' and dd_First_Name__c LIKE \'%'+String.escapeSingleQuotes(firstName)+'%\'';
        if (!lastName.equals(''))
          soql +=  ' and dd_Last_name__c LIKE \'%'+String.escapeSingleQuotes(lastName)+'%\'';
        if (!emrPro.equals(''))
          soql +=  ' and dd_Emergency_Provider__c LIKE \'%'+String.escapeSingleQuotes(emrPro)+'%\'';
        if (!gtf.equals(''))
          soql +=  ' and dd_GTF_Level__c LIKE \'%'+String.escapeSingleQuotes(gtf)+'%\'';
        
      }
      
      //Benn
      else if(!licType.equals('') || !licNumber.equals('') || !accType.equals('')){
          if(accType.equals('')){
              soql =label.ProviderSearchSOQL+' and id in (select DD_Service_Provider_Name__c from License__c where DD_Service_Provider_Name__c != null';
                if (!licType.equals(''))
                    soql += ' and DD_Type__c LIKE \'%'+String.escapeSingleQuotes(licType)+'%\'';
                if (!licNumber.equals(''))
                    soql += ' and name LIKE \'%'+String.escapeSingleQuotes(licNumber)+'%\'';
                if (!licEffFrom.equals(''))
                    soql += ' and DD_Effective_Date__c >= ' + licEffFrom;
                if (!licEffTill.equals(''))
                    soql += ' and DD_Effective_Date__c <= ' + licEffTill;
                if (!licExpFrom.equals(''))
                    soql += ' and DD_Expiration_Date__c >= ' + licExpFrom;
                if (!licExpTill.equals(''))
                    soql += ' and DD_Expiration_Date__c <= ' + licExpTill;                
                soql += ') ';
          }
          else if(licType.equals('') && licNumber.equals('')){
              soql =label.ProviderSearchSOQL+' and id in (select DD_Service_Provider_Name__c from Accreditation__c where DD_Service_Provider_Name__c != null';
                if (!accType.equals(''))
                    soql += ' and DD_Type__c LIKE \'%'+String.escapeSingleQuotes(accType)+'%\'';
                if (!accEffFrom.equals(''))
                    soql += ' and DD_Effective_Date__c >= ' + accEffFrom;
                if (!accEffTill.equals(''))
                    soql += ' and DD_Effective_Date__c <= ' + accEffTill;
                if (!accExpFrom.equals(''))
                    soql += ' and DD_Expiration_Date__c >= ' + accExpFrom;
                if (!accExpTill.equals(''))
                    soql += ' and DD_Expiration_Date__c <= ' + accExpTill;                
              soql += ') ';
          }
          else {
              soql =label.ProviderSearchSOQL+' and id in (select DD_Service_Provider_Name__c from License__c where DD_Service_Provider_Name__c != null';
                if (!licType.equals(''))
                    soql += ' and DD_Type__c LIKE \'%'+String.escapeSingleQuotes(licType)+'%\'';
                if (!licNumber.equals(''))
                    soql += ' and name LIKE \'%'+String.escapeSingleQuotes(licNumber)+'%\'';
                if (!licEffFrom.equals(''))
                    soql += ' and DD_Effective_Date__c >= ' + licEffFrom;
                if (!licEffTill.equals(''))
                    soql += ' and DD_Effective_Date__c <= ' + licEffTill;
                if (!licExpFrom.equals(''))
                    soql += ' and DD_Expiration_Date__c >= ' + licExpFrom;
                if (!licExpTill.equals(''))
                    soql += ' and DD_Expiration_Date__c <= ' + licExpTill;
                soql += ') ';  
                system.debug('soql>>>>>>>>>>>>>'+soql);            
                soql2 =label.ProviderSearchSOQL+' and id in (select DD_Service_Provider_Name__c from Accreditation__c where DD_Service_Provider_Name__c != null';
                if (!accType.equals(''))
                    soql2 += ' and DD_Type__c LIKE \'%'+String.escapeSingleQuotes(accType)+'%\'';
                if (!accEffFrom.equals(''))
                    soql2 += ' and DD_Effective_Date__c >= ' + accEffFrom;
                if (!accEffTill.equals(''))
                    soql2 += ' and DD_Effective_Date__c <= ' + accEffTill;
                if (!accExpFrom.equals(''))
                    soql2 += ' and DD_Expiration_Date__c >= ' + accExpFrom;
                if (!accExpTill.equals(''))
                    soql2 += ' and DD_Expiration_Date__c <= ' + accExpTill;                
              soql2 += ') ';
              system.debug('soql2>>>>>>>>>>>>>'+soql2);
          }
        
      }
     //Benny
   
    system.debug('SOQL >'+soql);
    runQuery();

    return null;
  }
    public  List<String> EmrgncyProVal
    { 
        get{
           List<string> options = new List<string>();
           Schema.DescribeFieldResult fieldResult = account.dd_Emergency_Provider__c.getDescribe();
           for( Schema.PicklistEntry f : fieldResult.getPicklistValues())
           {
              options.add(f.getLabel());
           }       
           return options;
        }
       set;
    } 
        public  List<String> licTypeVal
        {
            get{
               List<string> options = new List<string>();
               Schema.DescribeFieldResult fieldResult = License__c.DD_Type__c.getDescribe();
               for( Schema.PicklistEntry f : fieldResult.getPicklistValues())
               {
                  options.add(f.getLabel());
               }       
               return options;
            }
           set;
    } 
    public  List<String> accTypeVal
        {
            get{
               List<string> options = new List<string>();
               Schema.DescribeFieldResult fieldResult = Accreditation__c.DD_Type__c.getDescribe();
               for( Schema.PicklistEntry f : fieldResult.getPicklistValues())
               {
                  options.add(f.getLabel());
               }       
               return options;
            }
           set;
    } 

    
    public  List<String> gtfLvl
    { 
        get{
           List<string> options = new List<string>();
           Schema.DescribeFieldResult fieldResult = account.dd_GTF_Level__c.getDescribe();
           for( Schema.PicklistEntry f : fieldResult.getPicklistValues())
           {
              options.add(f.getLabel());
           }       
           return options;
        }
       set;
    } 
    public  List<String> refType
    { 
        get{
           List<string> options = new List<string>();
           Schema.DescribeFieldResult fieldResult = dd_Alternate_References__c.dd_Reference_Type__c.getDescribe();
           for( Schema.PicklistEntry f : fieldResult.getPicklistValues())
           {
              options.add(f.getLabel());
           }       
           return options;
        }
       set;
    } 
}