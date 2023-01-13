public class AccountHandler {
    public static void insertAccount(Integer numberofnewaccounts){
        List<Account> addAccounts = new List<Account>();
        Integer N=1;
        while(N<=numberofnewaccounts){
            Account store = new Account();
            store.Name= 'Acme Inc ' + N;
            store.AccountNumber = ' A000' + N;
            addAccounts.add(store);
            N=N+1;
            
        }
      insert addAccounts;
    }
}