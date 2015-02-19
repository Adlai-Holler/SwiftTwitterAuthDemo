
import UIKit


class ReactiveCocoaAuthViewController: AuthViewController {
    
    override init() {
        super.init(nibName: nil, bundle: nil)
        title = "ReactiveCocoa Auth"
    }
    
    override func doAuth() {
        super.doAuth()
        authWithTwitterAccount(sourceViewController: self).start(next: {
            self.updatePlaceholder($0, errorOrNil: nil)
        }, error: {
            self.updatePlaceholder(nil, errorOrNil: $0)
        })
    }
}

