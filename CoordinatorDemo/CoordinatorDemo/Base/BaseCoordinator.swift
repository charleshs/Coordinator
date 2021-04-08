import Coordinator
import UIKit

class BaseCoordinator<T>: Coordinator<T> {
    typealias Completion = (CoordinatedResult) -> Void
    
    let presenter: UIViewController

    init(presenter: UIViewController) {
        self.presenter = presenter
    }

    deinit {
        print("deinit - \(type(of: self))")
    }
}
