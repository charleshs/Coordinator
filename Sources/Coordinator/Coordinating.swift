import Foundation

public protocol Coordinating: AnyObject {
    /// Type of value to be passed back to the parent coordinator when the current one completes.
    associatedtype CoordinatedResult

    var uniqueIdentifier: UUID { get }

    func start(onCompleted: @escaping (CoordinatedResult) -> Void) throws
}
