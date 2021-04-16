import Combine
import Coordinator
import UIKit

final class ContactListCoordinator: BaseCoordinator<Bool> {
    private var disposables: Set<AnyCancellable> = []

    override func start(onCompleted: @escaping Completion) throws {
        let contactManager = ContactManager()

        let contactListVC = ContactListViewController.initFromStoryboard(creator: { coder -> ContactListViewController? in
            ContactListViewController(coder: coder, contactRepository: contactManager, contactOperation: contactManager)
        })

        contactListVC.$goEditing
            .sink { [weak self] contact in
                let presenter: UIViewController = contactListVC.navigationController ?? contactListVC
                let coordinator = ContactEditorCoordinator(contact: contact, presenter: presenter)

                self?.launch(coordinator) { [weak contactListVC] contact in
                    guard let contact = contact else { return }
                    contactListVC?.update(contact: contact)
                }
            }
            .store(in: &disposables)

        display(contactListVC, by: presenter)
    }
}
