
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        let tabBarVC = UITabBarController()
        let conventionalVC = ConventionalAuthViewController()
        let reactiveCocoaVC = ReactiveCocoaAuthViewController()
        tabBarVC.viewControllers = [ conventionalVC, reactiveCocoaVC ]
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window!.rootViewController = tabBarVC
        window!.makeKeyAndVisible()
        return true
    }
}

