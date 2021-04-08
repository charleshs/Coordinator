import Combine
import Coordinator
import UIKit

final class ContactListCoordinator: BaseCoordinator<Bool> {
    private var disposables: Set<AnyCancellable> = []

    override func start(onCompleted: @escaping (Bool) -> Void) throws {
        let contactListVC = ContactListViewController.initFromStoryboard()
        contactListVC.title = "Contacts"

        contactListVC.$didTapAddBarButton
            .compactMap { $0 }
            .sink { [weak self] _ in
                let coordinator = ContactEditorCoordinator(presenter: contactListVC.navigationController ?? contactListVC)
                self?.launch(coordinator) { _ in }
            }
            .store(in: &disposables)

        display(contactListVC, by: presenter)
    }
}
