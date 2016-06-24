global with sharing class ProviderService 
{       
    global static void searchProvider(Set<ID> providerIds)
    {
        // Create unit of work to capture work and commit it under one transaction
        /*SObjectUnitOfWork uow = new SObjectUnitOfWork(SERVICE_SOBJECTS);
        
        // Query Opportunities and apply discount
        Account providers = new Account(
            name = new ProvidersSelector().selectById(providerIds));               
        providers.applySearch(providerIds, uow);
        
        // Commit updates to opportunities      
        uow.commitWork();  */                    
    }

    private static List<Schema.SObjectType> SERVICE_SOBJECTS = 
        new Schema.SObjectType[] { 
            Account.SObjectType
            };
}