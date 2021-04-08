import Combine
import UIKit

final class ContactEditorViewController: BaseViewController {
    @Published private(set) var goBack: Void?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func willLeaveParent() {
        goBack = ()
    }
}
