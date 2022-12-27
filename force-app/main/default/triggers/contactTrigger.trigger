trigger contactTrigger on Contact (after insert,after update,after delete) {
    
        
    if(Trigger.isAfter){
        
        if(Trigger.isInsert){
            
            ContactTriggerHandler.afterInsert(Trigger.New); //onAfterInsert
        }
        
        else if(Trigger.isUpdate){
            ContactTriggerHandler.afterUpdate(Trigger.New,Trigger.old);
        }
           
        else if(Trigger.isDelete){
            ContactTriggerHandler.afterDelete(Trigger.old);
            
        }
    }
    
}