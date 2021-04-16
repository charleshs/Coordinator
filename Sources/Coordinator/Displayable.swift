#if canImport(UIKit)
import UIKit

public protocol Displayable {
    /// Displays a view controller.
    /// - Parameters:
    ///   - viewController: The view controller to be displayed.
    ///   - presentingContext: The context where the view controller is displayed.
    ///   - option: The option used to configure the displaying behavior.
    ///   - completion: A completion block called after the display.
    func display(_ viewController: UIViewController, by presentingContext: UIViewController, option: Displayer.Option, completion: (() -> Void)?)
}

extension Displayable where Self: Coordinating {
    public func display(
        _ viewController: UIViewController,
        by presentingContext: UIViewController,
        option: Displayer.Option = .automatic,
        completion: (() -> Void)? = nil
    ) {
        Displayer(viewController: viewController, presentingContext: presentingContext).display(with: option, completion: completion)
    }
}

extension Coordinator: Displayable {}

#endif
