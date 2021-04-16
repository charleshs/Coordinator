#if canImport(UIKit)
import UIKit

public struct Displayer {
    public enum Option {
        /// Performs default display behavior on `viewController`, which depends on the type of `presentingContext`.
        /// If it's a tab bar controller, `viewController` will be added as the root of a tab.
        /// If it's a navigation controller, `viewController` will be pushed to the top.
        /// If it's a plain view controller, `viewController` will be presented by it.
        case automatic

        /// Embeds `viewController` in a navigation controller. If `presentingContext` is
        /// a navigation controller, this option has no effect.
        case embedded(in: UINavigationController)

        /// The `viewController` will be presented by `presentingContext`
        case present
    }

    private let viewController: UIViewController
    private let presentingContext: UIViewController

    init(viewController: UIViewController, presentingContext: UIViewController) {
        self.viewController = viewController
        self.presentingContext = presentingContext
    }

    func display(with option: Option, completion: (() -> Void)? = nil) {
        let finalViewController: UIViewController

        switch option {
        case .automatic:
            finalViewController = viewController
        case .embedded(let navController):
            navController.setViewControllers([viewController], animated: false)
            finalViewController = navController
        case .present:
            return presentingContext.present(viewController, animated: true, completion: completion)
        }

        switch presentingContext {
        case let tab as UITabBarController:
            tab.setViewControllers(finalViewController.appended(to: tab.viewControllers), animated: true)
        case let nav as UINavigationController:
            // Ignore `.embedded`
            nav.pushViewController(viewController, animated: true)
        default:
            presentingContext.present(finalViewController, animated: true, completion: completion)
        }
    }
}

private extension UIViewController {
    func appended(to viewControllers: [UIViewController]?) -> [UIViewController] {
        guard let viewControllers = viewControllers else {
            return [self]
        }
        return [viewControllers, [self]].flatMap { $0 }
    }
}

#endif
