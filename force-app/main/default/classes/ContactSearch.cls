public class ContactSearch {
    public static List<contact> searchForContacts(String str1,String str2){
       List<Contact> contsList = new List<Contact>();
        contsList=[Select Id,LastName from Contact
                  where (LastName=:str1 AND MailingPostalCode=:str2)];
        return contsList;
        
    }

}