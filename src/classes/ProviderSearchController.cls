public with sharing class ProviderSearchController {

  private String soql {get;set;}
  private String soql2 {get;set;}//Benny
  private Boolean addrDisable {get;set;}
  
  public List<account> providers {get;set;}
  public List<account> providers2 {get;set;}//Benny
  public account provider {get;set;}
    
   public void methodOne()
    {
        addrDisable = true;
        system.debug('Working');
    }

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
  public String debugSoql2 { //Benny
    get { return soql2;}
    set;
  }
   
  public ProviderSearchController() {
    soql = label.ProviderSearchSOQL;
    soql2 = 'SOQL';//Benny
    addrDisable = false;
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
      String duplicate;//Benny
      if(!soql2.equals('SOQL')){
            providers2 = Database.query(soql2 + ' order by ' + sortField + ' ' + sortDir + ' limit 20');
            providers2.addall(providers);
            providers.clear();
            //system.debug('providerssize>>>>>>>>>>>'+providers.size());
            //system.debug('providers2size>>>>>>>>>>>'+providers2.size());
              for (account acc : providers2){
                  duplicate = 'False';  
                  if (providers.size()>0){
                      for (account acc2 : providers){
                        //system.debug('acc>>>>>>>>>>>'+acc.get('Id'));
                        //system.debug('acc2>>>>>>>>>>>'+acc2.get('Id'));
                          if (acc2.get('Id') == acc.get('Id'))

                              duplicate = 'True';
                          }
                    }
                  if(duplicate != 'True'){
                    providers.add(acc);  
                    //system.debug('Provider3size>>>>>>>>>>>'+providers3.size());
                    }
                  //system.debug('myset>>>>>>>>>>>'+myset.size());*/
              }//Benny
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


  public PageReference newProvider() {
        
        //PageReference reference=new PageReference('https://www.google.com');  
        String firstName = Apexpages.currentPage().getParameters().get('firstname');
        String lastName = Apexpages.currentPage().getParameters().get('lastname');
        String emrPro = Apexpages.currentPage().getParameters().get('emrPro');
        String gtf = Apexpages.currentPage().getParameters().get('gtf'); 
        system.debug('variables>>>>>>>>>>>>>>>>'+firstname + '____' + lastname + '____' + emrPro + '______' + gtf);
        //PageReference reference=new PageReference('/001/e?retURL=%2F001%2Fo&00N35000000Hw5N=' + firstName);
        String url = '/001/e?retURL=%2F001%2Fo';
        if (lastName != '')
            url += '&acc2=' + lastname;
        if (firstname != '')
            url += '&00N35000000Hw5N=' + firstname;
        if (gtf != '')
            url += '&00N35000000Hw5S=' + gtf;
        if (emrPro != '')
            url += '&00N35000000Hw5X=' + emrPro;
        String url2 = '/setup/ui/recordtypeselect.jsp?ent=Account&retURL=%2F001%2Fo&save_new_url=%2F001%2Fe%3FretURL%3D%252F001%252Fo';
        PageReference reference=new PageReference(url2);
        reference.setRedirect(true);
        return reference;
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
      
    if(!refn.equals('') || !refType.equals('')){
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
    
      else if(!firstName.equals('') || !lastName.equals('') || !emrPro.equals('')){
        
        soql =label.ProviderSearchSOQL;
        if (!firstName.equals(''))
          soql += ' and dd_First_Name__c LIKE \'%'+String.escapeSingleQuotes(firstName)+'%\'';
        if (!lastName.equals(''))
          soql +=  ' and name LIKE \'%'+String.escapeSingleQuotes(lastName)+'%\'';
        if (!emrPro.equals(''))
          soql +=  ' and dd_Emergency_Provider__c LIKE \'%'+String.escapeSingleQuotes(emrPro)+'%\'';
        if (!gtf.equals(''))
          soql +=  ' and dd_GTF_Level__c LIKE \'%'+String.escapeSingleQuotes(gtf)+'%\'';
        
      }
      
      //Benny
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
    public  List<String> licTypeVal //Benny
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
    public  List<String> accTypeVal //Benny
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
}