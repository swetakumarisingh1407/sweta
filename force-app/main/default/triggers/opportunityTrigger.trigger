trigger opportunityTrigger on Opportunity (after insert,After update) {
    if(Trigger.isAfter){
          
        if(Trigger.isInsert){
            
            OpportunityTriggerHandler.onAfterInsert(Trigger.New); 
        }
        else if(Trigger.isUpdate){
            OpportunityTriggerHandler.onAfterUpdate(Trigger.New,Trigger.oldMap);
            
        }
    }
}