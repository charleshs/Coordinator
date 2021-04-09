import Combine
import Coordinator
import UIKit

final class ContactEditorCoordinator: BaseCoordinator<ContactModel?> {
    private var disposables: Set<AnyCancellable> = []

    override func start(onCompleted: @escaping Completion) throws {
        let contactEditorVC = ContactEditorViewController(nibName: nil, bundle: nil)

        contactEditorVC.$goBack
            .sink { onCompleted($0) }
            .store(in: &disposables)

        display(contactEditorVC, by: presenter)
    }
}
