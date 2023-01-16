public class MetaTriggerWithMap {
 public static void  onAfterInsert(list<Account> afterlist){
 //createContact
        list<contact> cont = new list<contact>();// for creating object of contact type
        integer count;
        // here we created list for fetching metadata details through query
        //list<Meta_Task__mdt> metadatadetail = [SELECT Meta_Name__c,Meta_Phone__c,Meta_Email__c FROM Meta_Task__mdt] ;
        // created map 
 Map < String, Meta_Task__mdt > metadataByPhoneMap = new Map <String, Meta_Task__mdt>(); 
        //for fetching details from list of metadata 
   for(Meta_Task__mdt metadetails : [SELECT Meta_Name__c,Meta_Phone__c,Meta_Email__c FROM Meta_Task__mdt]){
            metadataByPhoneMap.put(metadetails.Meta_Phone__c,metadetails); //adding key-values to the map
        }
        // fetching details from trigger.new 
        for(Account acct: afterlist)
       { 
           //checking the condition for account phone 
            
  if(acct.NumberOfContact__c != null && acct.NumberOfContact__c >0 && acct.NumberOfContact__c <=3 && metadataByPhoneMap.ContainsKey(acct.Phone)){
                
                for(Integer i=0; i<acct.NumberOfContact__c; i++)  
                {
                    contact con=new contact();
                    con.LastName=metadataByPhoneMap.get(acct.phone).Meta_Name__c;
                    con.Phone=metadataByPhoneMap.get(acct.phone).Meta_Phone__c;
                    con.Email=metadataByPhoneMap.get(acct.phone).Meta_Email__c;
                    con.AccountId=acct.Id;
                    cont.add(con);
                }}
  else if(acct.NumberOfContact__c >3)
            {
                 acct.addError('crossing the limit');
            } }
  insert cont;//inserting all the deatils of the contact to the the new account 
    }
 }