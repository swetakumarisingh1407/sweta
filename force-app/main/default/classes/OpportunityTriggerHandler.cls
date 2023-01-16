// code for handling opporunitytrigger
public class OpportunityTriggerHandler {
    // code for inserting new task
    public static void onAfterInsert (List<Opportunity> afterlist){
        contact con = [SELECT Id,lastName,email FROM contact where name='payal kumari'];
        List<task> listtask = New List<task>(); // creating list of task type
        Map < String, Opportunity_data__mdt > metadatanextstep = new Map <String, Opportunity_data__mdt>(); //creating map for custom data
        // fetching al the data from custom meta data 
        for(Opportunity_data__mdt metadetails : [SELECT Id,MasterLabel,TASK_SUBJECT__c FROM Opportunity_data__mdt])
        {  
            metadatanextstep.put(metadetails.MasterLabel,metadetails);
        }
        system.debug(' metadatanextstep  '+metadatanextstep);
        
        // fetching details of opporunity from trigger.new 
        Id recordtypename = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('NewCustomer').getRecordTypeId();
        for(opportunity opp: afterlist)
        {
            String str = opp.NextStep.toLowerCase();
            
            //according to the requriment we put the condition and adding the details to the task through custom meta data    
            if(opp.StageName =='Closed Won' && opp.Type == 'New Customer' && opp.CloseDate == system.today() && metadatanextstep.ContainsKey(str) && opp.RecordTypeId == recordtypename)
            {
                if(TaskDisables__c.getInstance(UserInfo.getProfileId()).TaskDisableAllow__c == true){
                    task tk = new task();
                    tk.Subject = metadatanextstep.get(str).TASK_SUBJECT__c;
                    tk.WhoId = con.Id;
                    tk.WhatId = opp.Id;
                    tk.Status = 'In Progress';
                    tk.ActivityDate = system.today()+5;
                    listtask.add(tk);//adding all the task details to the list of task type
                }
                
            }
        }
        insert listtask; // inserting the list
        // code for sening email 
        
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();//object created for sending mail
        message.toAddresses =new String[] {con.email};
            message.setSubject('Email test'); 
        message.plainTextBody = 'Task is successfully added ';
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {message});//for sending email to the owner 
        
    }
    //code for updating opportunity 
    public static void onAfterUpdate(List<Opportunity> newlist,map<Id,Opportunity> oldMap){
        List<task> listtask = New List<task>();
        List<ID> listopp = New List<ID>();
        // for fetching all the data from trigger.old 
        
        for(opportunity opp: newlist)
        {
            Boolean OldCloseLost=oldMap.get(opp.Id).StageName.equals('Closed Won');
            if(opp.StageName == 'Closed Won')
            {
                OpportunityTriggerHandler.onAfterInsert (newlist);
                    
            }
            else if(OldCloseLost &&  opp.StageName == 'Closed Lost') // according to the requriment 
            {
                listopp.add(opp.Id);
            }
        }
        list<task> taskList = [SELECT WhoId,ID FROM task WHERE WhatId IN:listopp];
        list<string> ls = new List<string>();
        for(task t:taskList){
            ls.add(t.WhoId); 
        }
        
        list<contact> cont = [select id ,email from contact where id IN : ls];
        system.debug('cont '+cont);
        for(contact co:cont ){
            //system.debug('co.email  '+co.email);
            //code for sending deleting message to the owner 
            
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();//object creation for email 
            message.toAddresses = new String[]{co.email};
                message.setSubject('delete Task'); 
            message.plainTextBody = 'Task is successfully deleted ';
            Messaging.sendEmail(new Messaging.SingleEmailMessage[]{message});//for sending deleting message to the owner 
            
        }
        DELETE taskList;
    } 
}