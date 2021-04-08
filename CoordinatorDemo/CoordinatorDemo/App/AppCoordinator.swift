import Coordinator
import UIKit

final class AppCoordinator: Coordinator<Bool> {
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    override func start(onCompleted: @escaping (Bool) -> Void) {
        let navController = UINavigationController()

        launch(ContactListCoordinator(presenter: navController))

        window.rootViewController = navController
        window.makeKeyAndVisible()
    }
}
