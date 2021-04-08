import UIKit

class BaseViewController: UIViewController {
    deinit {
        print("deinit - \(type(of: self))")
    }

    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        if parent == nil {
            willLeaveParent()
        }
    }

    /// Gets invoked when the controller is about to leave its container.
    func willLeaveParent() {}
}
