
import UIKit

class AuthViewController: UIViewController {
    let placeholder = AAPLPlaceholderView(frame: CGRectZero, title: nil, message: "Hello there!", image: nil, buttonTitle: "Try Auth", buttonAction: {})
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        placeholder.title = title
        placeholder.frame = view.bounds
        placeholder.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        placeholder.buttonAction = {[unowned self] in
            self.doAuth()
        }
        view.addSubview(placeholder)
    }
    
    func doAuth() {
        placeholder.message = "Attempting to auth…"
    }
    
    final func updatePlaceholder(resultOrNil: String?, errorOrNil: NSError?) {
        if let error = errorOrNil {
            placeholder.message = error.localizedDescription
        } else {
            placeholder.message = "Auth succeeded!"
        }
    }
}
