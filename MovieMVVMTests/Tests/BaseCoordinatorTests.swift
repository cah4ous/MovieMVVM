// BaseCoordinatorTests.swift
// Copyright © Alexandr T. All rights reserved.

@testable import MovieMVVM

import XCTest

/// Тесты координатора
final class BaseCoordinatorTests: XCTestCase {
    // MARK: - Private Properties

    private let mockCoordinator = MockCoordinator(window: UIWindow())

    private var baseCoordinator: BaseCoordinator?

    override func setUp() {
        baseCoordinator = BaseCoordinator(window: UIWindow())
    }

    override func tearDown() {
        baseCoordinator = nil
    }

    func testAddDependency() {
        baseCoordinator?.addDependency(mockCoordinator)
        XCTAssertNotNil(baseCoordinator)
    }

    func testRemoveDependency() {
        baseCoordinator?.addDependency(mockCoordinator)
        baseCoordinator?.removeDependency(mockCoordinator)
        guard let childCoordinators = baseCoordinator?.childCoordinators else { return }
        XCTAssertTrue(childCoordinators.isEmpty)
    }
}
