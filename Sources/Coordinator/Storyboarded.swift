#if canImport(UIKit)
import UIKit

public protocol Storyboarded {
    /// The storyboard which a view controller is loaded from. Use `Main.storyboard` if not specified.
    static var storyboard: UIStoryboard { get }
}

extension Storyboarded where Self: UIViewController {
    /// `Main.storyboard` if not implemented.
    public static var storyboard: UIStoryboard {
        return .main
    }

    /// Loads a view controller from the specified storyboard.
    /// - Parameter identifier: A piece of string identifying the view controller. Use the name of class if passing `nil`.
    /// - Returns: A view controller of the Storyboarded-conforming type.
    public static func initFromStoryboard(identifier: String? = nil) -> Self {
        let identifier = identifier ?? String(describing: self)

        if #available(iOS 13.0, tvOS 13.0, *) {
            return storyboard.instantiateViewController(identifier: identifier) as! Self
        } else {
            return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
        }
    }

    /// Creates the specified view controller from the storyboard and initializes it using your custom initialization code.
    /// - Parameters:
    ///   - identifier: A piece of string identifying the view controller. Use the name of class if passing `nil`.
    ///   - creator: A block containing your custom creation code for the view controller.
    @available(iOS 13.0, tvOS 13.0, *)
    public static func initFromStoryboard(identifier: String? = nil, creator: @escaping (NSCoder) -> Self?) -> Self {
        let identifier = identifier ?? String(describing: self)

        return storyboard.instantiateViewController(identifier: identifier) { coder -> Self? in
            return creator(coder)
        }
    }
}

private extension UIStoryboard {
    /// Representing `Main.storyboard`.
    static let main: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
}

#endif
