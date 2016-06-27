public with sharing class ProviderSearchController {

  private String soql {get;set;}
  
  public List<account> providers {get;set;}
    public account provider {get;set;}
    
  
  public String sortDir {
    get  { if (sortDir == null) {  sortDir = 'asc'; } return sortDir;  }
    set;
  }
  
  public String sortField {
    get  { if (sortField == null) {sortField = 'dd_Last_name__c'; } return sortField;  }
    set;
  }
  
  public String debugSoql {
    get { return soql + ' order by ' + sortField + ' ' + sortDir + ' limit 20'; }
    set;
  }
   
  public ProviderSearchController() {
    soql = label.ProviderSearchSOQL;
    runQuery();
  }
   
  public void toggleSort() {
   
    sortDir = sortDir.equals('asc') ? 'desc' : 'asc';
    
    runQuery();
  }
 
  public void runQuery() {

    try {
        system.debug('soql>>>'+soql);	
      providers = Database.query(soql + ' order by ' + sortField + ' ' + sortDir + ' limit 20');
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
    String state = Apexpages.currentPage().getParameters().get('state');
    String zip = Apexpages.currentPage().getParameters().get('zip');
    String apt = Apexpages.currentPage().getParameters().get('apt');
    String phone = Apexpages.currentPage().getParameters().get('phone');
    String parOrg = Apexpages.currentPage().getParameters().get('parOrg');
      
      
    if(!refn.equals('') ){
       soql =label.ProviderSearchSOQL+' and id in (select DD_Provider__c from dd_Alternate_References__c where dd_Provider__c != null';   
        if (!refn.equals(''))
          soql += ' and dd_Reference_Number__c LIKE \'%'+String.escapeSingleQuotes(refn)+'%\'';
        if (!refType.equals(''))
          soql +=  ' and dd_Reference_Type__c LIKE \'%'+String.escapeSingleQuotes(refType)+'%\'';  
        soql += ') ';
        system.debug('reference number SOQL'+soql);
      }
   
    
      if(!street.equals('') || !city.equals('')|| !state.equals('')|| !zip.equals('')|| !apt.equals('')|| !phone.equals('')){
       soql =label.ProviderSearchSOQL+' and id in (select dd_Provider__c from dd_Address__c where dd_Provider__c != null';
          if (!street.equals(''))
          soql += ' and Name LIKE \'%'+String.escapeSingleQuotes(street)+'%\'';
          if (!city.equals(''))
          soql +=  ' and dd_City__c LIKE \'%'+String.escapeSingleQuotes(city)+'%\''; 
          if (!state.equals(''))
          soql +=  ' and DD_State__c LIKE \'%'+String.escapeSingleQuotes(state)+'%\''; 
          if (!zip.equals(''))
          soql +=  ' and DD_Zip_Code__c ='+String.escapeSingleQuotes(zip); 
          if (!apt.equals(''))
          soql +=  ' and DD_Apartment_Number__c LIKE \'%'+String.escapeSingleQuotes(apt)+'%\''; 
          if (!phone.equals(''))
          soql +=  ' and DD_Phone__c LIKE \'%'+String.escapeSingleQuotes(phone)+'%\''; 
        soql += ') ';
      }
    
      else if(!firstName.equals('') || !lastName.equals('') || !emrPro.equals('') || !parOrg.equals('')){
        
        soql =label.ProviderSearchSOQL;
        if (!firstName.equals(''))
          soql += ' and dd_First_Name__c LIKE \'%'+String.escapeSingleQuotes(firstName)+'%\'';
        if (!lastName.equals(''))
          soql +=  ' and dd_Last_name__c LIKE \'%'+String.escapeSingleQuotes(lastName)+'%\'';
        if (!emrPro.equals(''))
          soql +=  ' and dd_Emergency_Provider__c LIKE \'%'+String.escapeSingleQuotes(emrPro)+'%\'';
        if (!gtf.equals(''))
          soql +=  ' and dd_GTF_Level__c LIKE \'%'+String.escapeSingleQuotes(gtf)+'%\'';
        if (!parOrg.equals(''))
          soql += ' and Parent LIKE \'%'+String.escapeSingleQuotes(parOrg)+'%\'';//Do it later
        
      }
   
   
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