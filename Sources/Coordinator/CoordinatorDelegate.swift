import Foundation

/// A delegated object that gets notified with coordinating events.
public protocol CoordinatorDelegate: AnyObject {
    /// Notifies the delegate that this coordinator has launched another coordinator.
    func coordinator<T, U: Coordinating>(_ coordinator: Coordinator<T>, didLaunch launchedCoordinator: U)

    /// Notifies the delegate that this coordinator has removed another coordinator from its managed children.
    func coordinator<T, U: Coordinating>(_ coordinator: Coordinator<T>, didRelease releasedCoordinator: U)

    /// Notifies the delegate that an error has occurred when launching another coordinator.
    func coordinator<T, U: Coordinating>(_ coordinator: Coordinator<T>, didFailLaunching anotherCoordinator: U, with error: Error)
}

extension CoordinatorDelegate {
    public func coordinator<T, U: Coordinating>(_ coordinator: Coordinator<T>, didLaunch launchedCoordinator: U) {}
    public func coordinator<T, U: Coordinating>(_ coordinator: Coordinator<T>, didRelease releasedCoordinator: U) {}
    public func coordinator<T, U: Coordinating>(_ coordinator: Coordinator<T>, didFailLaunching anotherCoordinator: U, with error: Error) {}
}
