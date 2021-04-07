import Foundation

/// The base implementation of `Coordinating` generic over the `CoordinatedResult`.
open class Coordinator<CoordinatedResult>: Coordinating {
    /// A globally unique identifier to distinguish the `Coordinator` object.
    public var uniqueIdentifier: UUID = UUID()

    public weak var delegate: CoordinatorDelegate?

    private var children: [UUID: AnyObject] = [:]

    public init() {}

    /// Starts the current coordinator.
    /// - Parameter onCompleted: The closure that is invoked when the coordinator completes.
    ///
    /// Subclasses must override this method and should not call `super.start(onCompleted:)` in its implementation.
    open func start(onCompleted: @escaping (CoordinatedResult) -> Void) {
        assertionFailure("Type `\(type(of: self))` must override `start(onCompleted:)` and not call `super.start(onCompleted:)` in its implementation.")
    }
}

extension Coordinator {
    /// Launches another coordinator.
    /// - Parameters:
    ///   - coordinator: The coordinator to be started.
    ///   - completion: The closure that is invoked when the other coordinator completes.
    public func launch<T: Coordinating, U>(_ coordinator: T, completion: @escaping (U) -> Void) where U == T.CoordinatedResult {
        coordinator.start(onCompleted: { [unowned self] value in
            completion(value)
            self.delegate?.coordinator(self, didComplete: coordinator)
            self.release(coordinator)
        })

        children[coordinator.uniqueIdentifier] = coordinator
        delegate?.coordinator(self, didLaunch: coordinator)
    }

    private func release<T: Coordinating>(_ coordinator: T) {
        children.removeValue(forKey: coordinator.uniqueIdentifier)
        delegate?.coordinator(self, didRelease: coordinator)
    }
}
