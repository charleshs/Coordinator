#if canImport(UIKit)
import UIKit

public protocol Displayable {
    /// Displays a view controller.
    /// - Parameters:
    ///   - viewController: The view controller to be displayed.
    ///   - presentingContext: The context where the view controller is displayed.
    ///   - tabNavigation: The navigation controller the displayed view controller, if the context is UITabBarController, is embedded to.
    func display(_ viewController: UIViewController, by presentingContext: UIViewController, tabNavigation: UINavigationController?)
}

extension Displayable where Self: Coordinating {
    public func display(_ viewController: UIViewController, by presentingContext: UIViewController, tabNavigation: UINavigationController?) {
        switch presentingContext {
        case let tab as UITabBarController:
            let displayingVC = tabNavigation.map { navController -> UIViewController in
                navController.setViewControllers([viewController], animated: false)
                return navController
            } ?? viewController
            tab.setViewControllers(displayingVC.appended(to: tab.viewControllers), animated: true)
        case let nav as UINavigationController:
            nav.pushViewController(viewController, animated: true)
        default:
            presentingContext.present(viewController, animated: true, completion: nil)
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
