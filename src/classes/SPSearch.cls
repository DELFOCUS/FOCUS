public with sharing class SPSearch {
    public String fName{get; set;}
    public String pId{get; set;}
    
    public SPSearch() {
        
    }
    public PageReference redirect() {
        
        //PageReference reference=new PageReference('https://www.google.com');   
        PageReference reference=new PageReference('/001/e?retURL=%2F001%2Fo&00N35000000Hw5N=' + fName);
        reference.setRedirect(true);
        return reference;
    }
    public void doSearch() { 
        system.debug('Benny------>' + fName);
    }
}