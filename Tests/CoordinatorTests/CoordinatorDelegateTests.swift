import XCTest
@testable import Coordinator

final class CoordinatorDelegateTests: XCTestCase {
    static var allTests = [
        ("testDidLaunch", testDidLaunch),
        ("testDidRelease", testDidRelease),
    ]

    private var launchedCoordinator: MockCoordinator?
    private var releasedCoordinator: MockCoordinator?
    
    func testDidLaunch() throws {
        let rootCoordinator = RootCoordinator()
        rootCoordinator.delegate = self
        let mockCoordinator = MockCoordinator()
        rootCoordinator.launch(mockCoordinator) { _ in }
        XCTAssertTrue(launchedCoordinator === mockCoordinator)
    }

    func testDidRelease() throws {
        let promise = expectation(description: "DidRelease")

        let rootCoordinator = RootCoordinator()
        rootCoordinator.delegate = self
        let mockCoordinator = MockCoordinator()
        rootCoordinator.launch(mockCoordinator) { [weak self] _ in
            // async
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                // executed after completion block
                XCTAssertTrue(self?.releasedCoordinator === mockCoordinator)
                promise.fulfill()
            }
        }
        wait(for: [promise], timeout: 5.0)
    }
}

extension CoordinatorDelegateTests: CoordinatorDelegate {
    func coordinator<T, U>(_ coordinator: Coordinator<T>, didLaunch launchedCoordinator: U) where U : Coordinating {
        self.launchedCoordinator = launchedCoordinator as? MockCoordinator
    }

    func coordinator<T, U>(_ coordinator: Coordinator<T>, didRelease releasedCoordinator: U) where U : Coordinating {
        self.releasedCoordinator = releasedCoordinator as? MockCoordinator
    }
}
