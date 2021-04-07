import XCTest
@testable import Coordinator

final class CoordinatorTests: XCTestCase {
    static var allTests = [
        ("testCoordinatedResult", testCoordinatedResult),
        ("testRelease_shouldNotCauseRetainCycle", testRelease_shouldNotCauseRetainCycle),
    ]

    private weak var retainedCoordinator: MockCoordinator?

    func testCoordinatedResult() throws {
        let promise = expectation(description: "Completion-block-with-CoordinatedResult")

        let rootCoordinator = RootCoordinator()
        let mockCoordinator = MockCoordinator()
        rootCoordinator.launch(mockCoordinator) { info in
            // async
            XCTAssertEqual(info, String(describing: MockCoordinator.self))
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5.0)
    }

    func testRelease_shouldNotCauseRetainCycle() throws {
        let promise = expectation(description: "Coordinator-released-after-completion")

        let rootCoordinator: RootCoordinator = RootCoordinator()
        var mockCoordinator: MockCoordinator? = MockCoordinator()
        rootCoordinator.launch(mockCoordinator!) { info in
            // async
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                // executed after completion block
                XCTAssertNil(self.retainedCoordinator)
                promise.fulfill()
            }
        }
        retainedCoordinator = mockCoordinator
        mockCoordinator = nil
        XCTAssertNotNil(retainedCoordinator)
        wait(for: [promise], timeout: 5.0)
    }
}
