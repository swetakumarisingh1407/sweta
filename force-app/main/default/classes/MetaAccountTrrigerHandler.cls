public class MetaAccountTrrigerHandler {
    public static void onAfterInsert(list<Account> afterlist){
        string phonenumber;
        string AccountId1;
        Integer count;
        list<contact> cont=new list<contact>();
        for(Account acc:afterlist){
          phonenumber = acc.phone;
            AccountId1=acc.Id;
            count=(Integer)acc.NumberOfContact__c;
        }
        Meta_Task__mdt meta=[SELECT Meta_Phone__c, Meta_Name__c, Meta_Email__c FROM Meta_Task__mdt where Meta_Phone__c =: phonenumber];
        if(meta.Meta_Phone__c!=null){
            for(integer i=0;i<count;i++){
				 	contact con=new contact();
				con.lastName=meta.Meta_Name__c;
                con.phone=meta.Meta_Phone__c;
                con.email=meta.Meta_Email__c;
                con.accountId=AccountId1;
                cont.add(con);
            }
       
         insert cont;   
        }
      
}
}