
import UIKit

class ConventionalAuthViewController: AuthViewController {
    
    override init() {
        super.init(nibName: nil, bundle: nil)
        title = "Conventional Auth"
    }
    
    override func doAuth() {
        super.doAuth()
        authWithTwitterAccount(sourceViewController: self) {[unowned self] (resultOrNil, errorOrNil) -> Void in
            self.updatePlaceholder(resultOrNil, errorOrNil: errorOrNil)
        }
    }
}

