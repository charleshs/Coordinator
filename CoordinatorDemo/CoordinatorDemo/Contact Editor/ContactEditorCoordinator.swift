import Combine
import Coordinator
import UIKit

final class ContactEditorCoordinator: BaseCoordinator<ContactModel?> {
    private var contact: ContactModel?
    private var disposables: Set<AnyCancellable> = []

    init(contact: ContactModel?, presenter: UIViewController) {
        self.contact = contact
        super.init(presenter: presenter)
    }

    override func start(onCompleted: @escaping Completion) throws {
        let contactEditorVC = ContactEditorViewController()
        contactEditorVC.editingContact = contact

        contactEditorVC.$goBack
            .sink { onCompleted($0) }
            .store(in: &disposables)

        display(contactEditorVC, by: presenter)
    }
}
