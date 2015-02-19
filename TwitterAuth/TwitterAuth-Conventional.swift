
import UIKit
import Accounts

private let accountStore = ACAccountStore()
public func authWithTwitterAccount(#sourceViewController: UIViewController, completion: (String?, NSError?) -> Void) {
    getAccessToTwitterAccounts { (accountsOrNil, error) -> Void in
        dispatch_async(dispatch_get_main_queue()) {
            if let accounts = accountsOrNil {
                getPreferredTwitterAccountFromUser(accounts, sourceViewController) { (accountOrNil, errorOrNil) -> Void in
                    if let account = accountOrNil {
                        authWithServer(account, { (resultOrNil, errorOrNil) -> Void in
                            if let result = resultOrNil {
                                completion(result, nil)
                            } else {
                                completion(nil, errorOrNil)
                            }
                        })
                    } else {
                        completion(nil, errorOrNil)
                    }
                }
            } else {
                completion(nil, error)
            }
        }
    }
}

/// :note: the completion block will be called on the arbitrary response queue from the Accounts framework
private func getAccessToTwitterAccounts(completion: (accounts: [ACAccount]?, errorOrNil: NSError?) -> Void) {
    let twitterType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)!
    accountStore.requestAccessToAccountsWithType(twitterType, options: nil) { (granted, error) -> Void in
        if !granted {
            completion(accounts: nil, errorOrNil: error ?? twitterUserRefusedAccessErr)
        } else {
            let accounts = accountStore.accountsWithAccountType(twitterType) as [ACAccount]
            completion(accounts: accounts, errorOrNil: error)
        }
    }
}



/**
prompts the user to pick among available Twitter accounts, by presenting a UIAlertController from `sourceViewController`

If the user has no Twitter accounts, the completion block will be called with `nil` before the function returns false
*/
private func getPreferredTwitterAccountFromUser(accounts: [ACAccount], sourceViewController: UIViewController, completion: (ACAccount?, NSError?) -> Void) -> Bool {
    precondition(NSThread.isMainThread())
    
    if isEmpty(accounts) {
        completion(nil, twitterNoAccountsErr)
        return false
    }
    
    let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
    for account in accounts {
        let action = UIAlertAction(title: account.username, style: .Default) {_ in
            completion(account, nil)
        }
        actionSheet.addAction(action)
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) {_ in
        completion(nil, twitterUserCanceledErr)
    }
    actionSheet.addAction(cancelAction)
    sourceViewController.presentViewController(actionSheet, animated: true, completion: nil)
    return true
}


private func authWithServer(account: ACAccount, completion: (String?, NSError?) -> Void) {
    let future = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC) * 2)
    dispatch_after(future, dispatch_get_main_queue()) {
        let hasError = arc4random_uniform(100) >= 50
        if hasError {
            completion(nil, twitterAuthNetworkErr)
        } else {
            completion("Success!", nil)
        }
    }
}