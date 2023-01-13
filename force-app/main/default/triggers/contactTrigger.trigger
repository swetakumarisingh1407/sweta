trigger contactTrigger on Contact (after insert,after update,after delete) {
    
if(Trigger.isAfter){
        
    if(Trigger.isInsert){
            
            ContactTriggerHandler.onAfterInsert(Trigger.New); 
        }
        
       else if(Trigger.isUpdate){
            ContactTriggerHandler.onAfterUpdate(Trigger.New,Trigger.old);
        }
           
           else if(Trigger.isDelete){
            ContactTriggerHandler.onAfterDelete(Trigger.old);
            
        }
    }
    
}