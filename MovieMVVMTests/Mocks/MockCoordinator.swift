// MockCoordinator.swift
// Copyright © Alexandr T. All rights reserved.

@testable import MovieMVVM

import XCTest

/// Мок главного координатора
final class MockCoordinator: BaseCoordinator {
    // MARK: - Public Method

    override func addDependency(_ coordinator: BaseCoordinator) {
        childCoordinators.append(coordinator)
    }

    override func removeDependency(_ coordinator: BaseCoordinator?) {
        childCoordinators.removeAll()
    }
}
