///////////////////////////////////////////////////////////////////////////////////////////
// Author: Sharif Elkassed
// Created: 02/03/2019
// Description: This class will be used specifically with Process Builder.
// 		The step are as follows:
// 		1) User submits an Account Application
// 		2) Process Builder creates a Joint or Standard Account
// 			-depending on Account Application Record Type
// 		3) This Apex class finds that Account Application
// 		4) This Apex class references the Account that was created in Step 2.
// 		5) This Apex class updates the Account field in the Account Application record
///////////////////////////////////////////////////////////////////////////////////////////

public class AccountApplication {
    // Set updateAccount as an Invocable Method so 
    //  that it can be referenced in the Process Builder
	@InvocableMethod(
       label='Update Newest Account Application' 
       description='Updates the Account Application with the Account that was just created'
   	)
    
    // Update the most recent Account Application
    public static void updateAccountApplication()
    {
       // Get the newest account application
       Account_Application__c newestApplication = [
            SELECT id
            FROM Account_Application__c
            ORDER BY CreatedDate DESC
            LIMIT 1
        ];
 		
        // Get the newest account
        Account newestAccount = [
            SELECT id
            FROM Account
            ORDER BY CreatedDate DESC
            LIMIT 1
        ];
        
        // Update the Account field on the Account Application record
        newestApplication.Account__c = newestAccount.id;
        update newestApplication;
    }
}