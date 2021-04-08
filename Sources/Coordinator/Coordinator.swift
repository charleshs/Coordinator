import Foundation

/// The base implementation of `Coordinating` generic over the `CoordinatedResult`.
open class Coordinator<CoordinatedResult>: Coordinating {
    /// The delegated object to be notified of coordinating events.
    public weak var delegate: CoordinatorDelegate?

    /// Coordinators managed by this coordinator.
    public private(set) var children: [UUID: AnyObject] = [:]

    /// A globally unique identifier to distinguish the `Coordinator` object.
    public let uniqueIdentifier: UUID = UUID()
    
    public init() {}

    /// Starts the current coordinator.
    /// - Parameter onCompleted: The closure that is invoked when the coordinator completes.
    ///
    /// Subclasses must override this method and should not call `super.start(onCompleted:)` in its implementation.
    open func start(onCompleted: @escaping (CoordinatedResult) -> Void) throws {
        assertionFailure("Type `\(type(of: self))` must override `start(onCompleted:)` and not call `super.start(onCompleted:)` in its implementation.")
    }
}

extension Coordinator {
    /// Launches another coordinator.
    /// - Parameters:
    ///   - coordinator: The coordinator to be started.
    ///   - completion: The closure that is invoked when the other coordinator completes.
    public func launch<T: Coordinating, U>(_ coordinator: T, completion: ((U) -> Void)? = nil) where U == T.CoordinatedResult {
        do {
            try coordinator.start(onCompleted: { [weak self, unowned coordinator] value in
                completion?(value)
                self?.release(coordinator)
            })
            children[coordinator.uniqueIdentifier] = coordinator
            delegate?.coordinator(self, didLaunch: coordinator)
        }
        catch {
            delegate?.coordinator(self, didFailLaunching: coordinator, with: error)
        }
    }

    private func release<T: Coordinating>(_ coordinator: T) {
        children.removeValue(forKey: coordinator.uniqueIdentifier)
        delegate?.coordinator(self, didRelease: coordinator)
    }
}
