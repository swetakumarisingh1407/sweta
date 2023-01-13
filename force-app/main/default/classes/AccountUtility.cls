public class AccountUtility {
    public static void viewAnnualRevenue(){
        list<Account> accountsList = new list<Account>();
        accountsList = [SELECT AnnualRevenue, Name
                        FROM Account];
        for( Account acct:accountsList){
            String acctRev = acct.Name+':'+acct.AnnualRevenue;
            system.debug(acctRev);
        }
    }

}