
import Foundation

public let twitterUserRefusedAccessErr = NSError(domain: "com.adlai.example", code: 3, userInfo: [NSLocalizedFailureReasonErrorKey: "You refused to give the app access to your Twitter accounts."])

public let twitterNoAccountsErr = NSError(domain: "com.adlai.example", code: 1, userInfo: [NSLocalizedFailureReasonErrorKey: "You do not have any Twitter accounts on your \(UIDevice.currentDevice().localizedModel)."])

public let twitterUserCanceledErr = NSError(domain: "com.adlai.example", code: 2, userInfo: [NSLocalizedFailureReasonErrorKey: "You canceled the process."])

/// a mock error when "authing" with our server
public let twitterAuthNetworkErr = NSError(domain: "com.adlai.example", code: 4, userInfo: [NSLocalizedFailureReasonErrorKey: "Error communicating with the server."])