import XCTest
@testable import Coordinator

final class CoordinatorTests: XCTestCase {
    static var allTests = [
        ("testCoordinatedResult", testCoordinatedResult),
        ("testRelease", testRelease),
    ]

    private var rootCoordinator: RootCoordinator!

    override func setUpWithError() throws {
        rootCoordinator = RootCoordinator()
    }

    override func tearDownWithError() throws {
        rootCoordinator = nil
    }

    func testCoordinatedResult() throws {
        let promise = expectation(description: "Callback-CoordinatedResult")

        let mockCoordinator = MockCoordinator()
        rootCoordinator.launch(mockCoordinator) { info in
            // async
            XCTAssertEqual(info, String(describing: MockCoordinator.self))
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5.0)
    }

    func testRelease() throws {
        let promise = expectation(description: "Coordinator-released-after-completion")

        weak var retainedMockCoordinator: MockCoordinator?
        var mockCoordinator: MockCoordinator? = MockCoordinator()
        rootCoordinator.launch(mockCoordinator!) { info in
            // async
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                // executed after completion block
                XCTAssertNil(retainedMockCoordinator)
                promise.fulfill()
            }
        }
        retainedMockCoordinator = mockCoordinator
        mockCoordinator = nil
        XCTAssertNotNil(retainedMockCoordinator)
        wait(for: [promise], timeout: 5.0)
    }
}

private final class RootCoordinator: Coordinator<String> {
    override func start(onCompleted: @escaping (String) -> Void) {}
}

private final class MockCoordinator: Coordinator<String> {
    override func start(onCompleted: @escaping (String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            onCompleted("\(type(of: self))")
        }
    }
}
