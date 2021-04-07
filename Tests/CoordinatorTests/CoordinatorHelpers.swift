import Coordinator
import Foundation

final class RootCoordinator: Coordinator<String> {
    override func start(onCompleted: @escaping (String) -> Void) {}
}

final class MockCoordinator: Coordinator<String> {
    override func start(onCompleted: @escaping (String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            onCompleted("\(type(of: self))")
        }
    }
}
