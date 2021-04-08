import Combine
import Coordinator
import UIKit

final class ContactEditorCoordinator: BaseCoordinator<Bool> {
    private var disposables: Set<AnyCancellable> = []

    override func start(onCompleted: @escaping (Bool) -> Void) throws {
        let contactEditorVC = ContactEditorViewController(nibName: nil, bundle: nil)

        contactEditorVC.$goBack
            .compactMap { $0 }
            .sink { _ in onCompleted(true) }
            .store(in: &disposables)

        display(contactEditorVC, by: presenter)
    }
}
