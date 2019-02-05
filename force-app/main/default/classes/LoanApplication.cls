///////////////////////////////////////////////////////////////////////////////////////////
// Author: Sharif Elkassed
// Created: 02/04/2019
// Description: This class will be used specifically with Process Builder.
// 		The step are as follows:
// 		1) User submits an Loan Application
// 		2) Loan Officer approves the Loan Application
// 		3) Process Builder creates a Loan
// 			- Using the Loan Amount field from the Loan Application
// 		4) This Apex class finds that Loan Application
// 		5) This Apex class references the Loan that was created in Step 3.
// 		6) This Apex class updates the Account balance field
// 			- Adds the approved Loan amount to the current balance
///////////////////////////////////////////////////////////////////////////////////////////

public class LoanApplication {
    // Set updateAccount as an Invocable Method so 
    //  that it can be referenced in the Process Builder
	@InvocableMethod(
       label='Update Account Balance on Loan Approval' 
       description='Updates the Account balance, adding the approved loan amount'
   	)
    
    public static void updateBalanceWithLoan(){
        // Retrieve the newest Loan Application
        Loan_Application__c newestApplication = [
            SELECT id, Loan_Amount__c, Account__c
            FROM Loan_Application__c
            ORDER BY CreatedDate DESC
            LIMIT 1
        ];
        
        // Retrieve the ID of the Account related to the Loan Application
        ID relatedAccountID = newestApplication.Account__c;
        
        // Use the ID to retrieve actual Account record
        Account relatedAccount = [
            SELECT name, balance__c
            FROM Account
            WHERE id = :relatedAccountID
        ];
        
        // Update the Account balance by adding the approved Loan amount
        relatedAccount.balance__c += newestApplication.Loan_Amount__c;
        update relatedAccount;
        
    }

}