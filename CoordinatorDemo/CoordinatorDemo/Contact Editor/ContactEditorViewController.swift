import Combine
import UIKit

final class ContactEditorViewController: BaseViewController {
    @Published var editingContact: ContactModel?
    @Published private(set) var goBack: ContactModel?

    @IBOutlet private var nameTextField: UITextField!
    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var phoneNumberTextField: UITextField!

    private var disposables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        subscribe()
    }

    override func willLeaveParent() {
        guard let name = nameTextField.validText,
              let email = emailTextField.validText,
              let phoneNumber = phoneNumberTextField.validText else {
            return goBack = nil
        }
        goBack = ContactModel(name: name, email: email, phoneNumber: phoneNumber, uuid: editingContact?.uuid ?? UUID())
    }

    private func setup() {
        title = "編輯連絡人"
    }

    private func subscribe() {
        $editingContact
            .receive(on: DispatchQueue.main)
            .sink { [weak self] contact in self?.render(with: contact) }
            .store(in: &disposables)
    }

    private func render(with contact: ContactModel?) {
        guard let contact = contact else { return }

        nameTextField.text = contact.name
        emailTextField.text = contact.email
        phoneNumberTextField.text = contact.phoneNumber
    }
}

private extension UITextField {
    var validText: String? {
        guard let text = text, !text.isEmpty else { return nil }
        return text
    }
}
