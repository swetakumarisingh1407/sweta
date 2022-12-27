public class ContactTriggerHandler {
    
    // method for insetring 
    public static void onAfterInsert(List<Contact>afterlist){
        
        List<Id> accountIdList = new List<Id>();
        for(contact c:afterlist){
          accountIdList .add(c.AccountId); 
        }
        
        List<Account> acctsWithContacts = [SELECT ID,NumberOfContact__c,(SELECT ID FROM Contacts)
                                           FROM Account
                                           WHERE ID IN:accountIdList];
        
        for(Account acc:acctsWithContacts){
            acc.NumberOfContact__c = acc.Contacts.Size();
        }
        
        UPDATE acctsWithContacts;  
    }
    
    
    // method for updating 
    public static void onAfterUpdate(List<Contact>afterupdate1,List<Contact>afterupdate2){
        
        List<Id> accountIdList = new List<Id>();
        
        for(contact c:afterupdate1){
            accountIdList.add(c.AccountId);
        }
        
        for(contact c: afterupdate2){
            accountIdList.add(c.AccountId);
        }
        
        List<Account> acctsWithContacts = [SELECT ID,NumberOfContact__c,(SELECT ID FROM Contacts)
                                           FROM Account
                                           WHERE ID IN:accountIdList];
        
        for(Account acc:acctsWithContacts){
            acc.NumberOfContact__c = acc.Contacts.Size();
        }
        
        UPDATE acctsWithContacts; 
        
        
    }
    
    //method for deleting 
    public static void onAfterDelete(List<Contact>aftrdel ){
        List<Id> accountIdList = new List<Id>();
        for(contact c:aftrdel){
            accountIdList.add(c.AccountId);
        }
        List<Account> acctsWithContacts = [SELECT ID,NumberOfContact__c,(SELECT ID FROM Contacts)
                                           FROM Account
                                           WHERE ID IN:accountIdList];
        for(Account acc:acctsWithContacts){
            acc.NumberOfContact__c = acc.Contacts.Size();
        }
        UPDATE acctsWithContacts; 
        
    }
    
    
}