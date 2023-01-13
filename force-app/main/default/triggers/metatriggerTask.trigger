trigger metatriggerTask on Account (after insert) {
    
    if(Trigger.isAfter&& Trigger.isInsert){
        
       MetaTriggerWithMap.onAfterInsert(Trigger.New);
    }   

}

//trigger name = AccountTrigger