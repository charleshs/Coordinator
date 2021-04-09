import Combine
import UIKit

final class ContactEditorViewController: BaseViewController {
    @Published private(set) var goBack: ContactModel?

    @IBOutlet private var nameTextField: UITextField!
    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var phoneNumberTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func willLeaveParent() {
        if let name = nameTextField.validText,
           let email = emailTextField.validText,
           let phoneNumber = phoneNumberTextField.validText {
            goBack = ContactModel(name: name, email: email, phoneNumber: phoneNumber)
        }

        return goBack = nil
    }
}

private extension UITextField {
    var validText: String? {
        guard let text = text, !text.isEmpty else { return nil }
        return text
    }
}
