
import UIKit
import ReactiveCocoa
import Accounts

private let accountStore = ACAccountStore()

public func authWithTwitterAccount(#sourceViewController: UIViewController) -> SignalProducer<String, NSError> {
    return getAccessToTwitterAccounts()
        |> observeOn(UIScheduler())
        |> mergeMap { getPreferredTwitterAccountFromUser($0, sourceViewController) }
        |> mergeMap { authWithServer($0) }
}

private func getAccessToTwitterAccounts() -> SignalProducer<[ACAccount], NSError> {
    return SignalProducer {sink, disposable in
        let twitterType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)!
        accountStore.requestAccessToAccountsWithType(twitterType, options: nil) { (granted, error) -> Void in
            if !granted {
                sendError(sink, error ?? twitterUserRefusedAccessErr)
            } else {
                let accounts = accountStore.accountsWithAccountType(twitterType) as [ACAccount]
                sendNext(sink, accounts)
                sendCompleted(sink)
            }
        }
    }
}

private func getPreferredTwitterAccountFromUser(accounts: [ACAccount], sourceViewController: UIViewController) -> SignalProducer<ACAccount, NSError> {
    return SignalProducer { sink, disposable in
        precondition(NSThread.isMainThread())
        
        if isEmpty(accounts) {
            sendError(sink, twitterNoAccountsErr)
            return
        }
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        for account in accounts {
            let action = UIAlertAction(title: account.username, style: .Default) {_ in
                sendNext(sink, account)
                sendCompleted(sink)
            }
            actionSheet.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) {_ in
            sendError(sink, twitterUserCanceledErr)
        }
        actionSheet.addAction(cancelAction)
        sourceViewController.presentViewController(actionSheet, animated: true, completion: nil)
    }
}

private func authWithServer(account: ACAccount) -> SignalProducer<String, NSError> {
    return SignalProducer { sink, disposable in
        let hasError = arc4random_uniform(100) >= 50
        if hasError {
            sendError(sink, twitterAuthNetworkErr)
        } else {
            sendNext(sink, "Success!")
            sendCompleted(sink)
        }
    }
    |> delay(2.0, onScheduler: QueueScheduler.mainQueueScheduler)
}