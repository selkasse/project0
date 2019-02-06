public class Apex0Exercises {
    
    // Returns true if character1 and character2 
    //   are matching left and right Parenthesis 
    public static boolean isMatchingPair(Integer character1, Integer character2) 
    { 
       if (character1 == 40 && character2 == 41) 
         return true; 
       else if (character1 == 123 && character2 == 125) 
         return true; 
       else if (character1 == 91 && character2 == 93) 
         return true; 
       else
         return false; 
    } 
    //////////////////////////////////////////////////////////////////////////////////
    public static Integer[] sortArray( Integer[] intList ) 
    {
        for(Integer i =1; i< intList.size(); i++)
        {
            Integer k = i;
            while(k > 0 && intList[k] < intList[k-1] )
            {
                Integer temp = intList[k-1]; 
                intList[k-1] = intList[k]; 
                intList[k] = temp; 
                k--;
            }
        }	
		return intList;
    }
    //////////////////////////////////////////////////////////////////////////////////
    public static void printArray(Integer[] intList)
    {
        for (Integer i = 0; i < intList.size(); i++){
                System.debug(intList[i]);
        }
        System.debug('');
    }
    //////////////////////////////////////////////////////////////////////////////////
    public static Integer nFibonacci( Integer n )
    {
        if(n==0) return 0; 
        if(n==1) return 1;
        else
            return nFibonacci(n-1) + nFibonacci(n-2);
    }
    //////////////////////////////////////////////////////////////////////////////////
    public static Integer nFactorial( Integer n) 
    {
        if (n<0) return -1;
        if(n==0) return 1;
        return n*nFactorial(n-1);
    }
    //////////////////////////////////////////////////////////////////////////////////
    public static Integer[] rotateLeftNTimes( Integer[] ar, Integer n) 
    {
        // Create List of same size to hold rotated values
        Integer[] rotatedArray = new Integer[ar.size()];
        for(Integer i =0; i < ar.size(); i++){
            // Use the math.mod() method to account for values of n that are 
            //  larger than array.size()
            rotatedArray[i] = ar[math.mod((i+n), ar.size())];
            
        }
        return rotatedArray;
    }
    //////////////////////////////////////////////////////////////////////////////////
    public static boolean bracketsAreBalanced(String s) {

        return isValid(s);
    }
    //////////////////////////////////////////////////////////////////////////////////
    public static boolean isValid(String expression)
    {
        Stack bracketStack = new Stack();
        for(Integer i = 0; i < expression.length(); i++)
        {
            // ASCII : '{' = 123 ; '(' = 40 ; '[' = 91
            // Push to the stack if open bracket
            if (expression.charAt(i) == 123 
                || expression.charAt(i) == 40
                || expression.charAt(i) == 91)
            {
                bracketStack.push(expression.charAt(i)); 
            } 

            // ASCII : '}' = 125 ; ')' = 41 ; ']' = 93
            // If ending bracket, pop from stack and check if the  
            //   popped bracket is a matching pair
            if (expression.charAt(i) == 125         
                || expression.charAt(i) == 41 
                || expression.charAt(i) == 93) 
            {  
                // Check for an ending bracket without a pair
               if (bracketStack.isEmpty()) 
               { 
                    return false; 
               }  

               // Check if the top element from stack matches the current element 
               else if (!isMatchingPair(bracketStack.pop(), expression.charAt(i))) 
                 { 
                     return false; 
                 } 
            } 
        }
        /* If there is something left in expression  
          then there is a starting parenthesis without  
          a closing parenthesis */
        
       if (bracketStack.isEmpty()) 
            return true; /*balanced*/
       else
            return false; /*not balanced*/
         
    }
    //////////////////////////////////////////////////////////////////////////////////
    public static void updateAccountBalance(String accountName){

        Account accountToUpdate = [
            SELECT id, name, balance__c
            FROM Account
            WHERE name = :accountName 
        ];

        // need to also get the RecordType 
        // to determine if Withrawal of Deposit
        List<Transaction__c> transactions = [
            SELECT id, amount__c, RecordTypeID, status__c
            FROM Transaction__c
            WHERE Account__r.id = :accountToUpdate.id AND status__c = 'Pending'
        ];

        System.debug(transactions);
        // Deposit RecordType ID: 0121U000000ElmWQAS
        // Withdrawal RecordType ID: 0121U000000ElmbQAC
        for (Transaction__c trans : transactions) {
           
            if(trans.status__c == 'Pending')
            {
                 // Deposit
                if (trans.RecordTypeID == '0121U000000ElmWQAS')
                    accountToUpdate.balance__c += trans.amount__c;
                else
                    // Withdrawal
                    accountToUpdate.balance__c -= trans.amount__c;
                // Update the status so that the transaction is not processed 
                //  more than once
                trans.status__c = 'Processed';
            }   
        }
        update accountToUpdate;
        update transactions;
    }
    //////////////////////////////////////////////////////////////////////////////////
    // Close all CA Leads and update their description
    public static void updateCALeads(){
        List<Lead> leads = [
            SELECT id, state, status, description
            FROM Lead WHERE state='CA'
        ];

        for(Lead thisLead : leads){
            thisLead.status = 'Closed - Not Converted';
            thisLead.description = 'We are no longer doing business in California'; 

        }

        update leads;
    }
    //////////////////////////////////////////////////////////////////////////////////
    // Update the Account size based on the number of employees
    public static void updateAccountSize(){
        List<Account> accounts = [
            SELECT id, name, size__c, numberOfEmployees
            FROM Account
        ];
        
        for(Account acct: accounts){
            if (acct.numberOfEmployees >= 1 && acct.numberOfEmployees <= 1000)
                acct.size__c = 'Small';
            else if (acct.numberOfEmployees >= 1001 && acct.numberOfEmployees <= 10000)
                acct.size__c = 'Medium';
            else   
                acct.size__c = 'Large';
        } 
        update accounts;      
    }
    //////////////////////////////////////////////////////////////////////////////////
    // Change the status of the account based on the balance
    public static void updateAccountStatus(String accountName){
        Account acct = [
            SELECT id, name, balance__c, status__c
            FROM Account WHERE name = :accountName
        ];

        if (acct.balance__c < 0)
            acct.status__c = 'Overdrawn';
        else if (acct.balance__c > 0 && acct.balance__c < 9999)
            acct.status__c = 'Good Standing';
        else   
            acct.status__c = 'Big Wig';

        update acct;

    }
    //////////////////////////////////////////////////////////////////////////////////
    // Close past due opportunities
    public static void closePastDueOpportunities(){
        List<Opportunity> opportunities = [
            SELECT Name, CloseDate, StageName 
            FROM Opportunity 
            WHERE CloseDate < TODAY AND StageName != 'Closed Won'
        ];

        for(Opportunity oppty: opportunities){
            oppty.stageName = 'Closed Lost';
        }

        update opportunities;
    }

    //////////////////////////////////////////////////////////////////////////////////
    // Create a transaction for an account
    public static void createTransaction(String accountName){
        Account relatedAcct = [
            SELECT id, name
            FROM Account WHERE name = :accountName
        ];
        // No record type specified.  Will default to 'Deposit'
        Transaction__c newTrans = new Transaction__c();
        Decimal transAmount = 87.00;
        newTrans.Account__c = relatedAcct.id;
        newTrans.amount__c = transAmount;
        newTrans.status__c = 'Pending';

        insert newTrans;

    }
}