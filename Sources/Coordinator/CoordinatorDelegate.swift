import Foundation

/// A delegated object that gets notified with coordinating events.
public protocol CoordinatorDelegate: AnyObject {
    func coordinator<T, U: Coordinating>(_ coordinator: Coordinator<T>, didLaunch launchedCoordinator: U)
    func coordinator<T, U: Coordinating>(_ coordinator: Coordinator<T>, didComplete completedCoordinator: U)
    func coordinator<T, U: Coordinating>(_ coordinator: Coordinator<T>, didRelease releasedCoordinator: U)
}

extension CoordinatorDelegate {
    public func coordinator<T, U: Coordinating>(_ coordinator: Coordinator<T>, didLaunch launchedCoordinator: U) {}
    public func coordinator<T, U: Coordinating>(_ coordinator: Coordinator<T>, didComplete completedCoordinator: U) {}
    public func coordinator<T, U: Coordinating>(_ coordinator: Coordinator<T>, didRelease releasedCoordinator: U) {}
}
