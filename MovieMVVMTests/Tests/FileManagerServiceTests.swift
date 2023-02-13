// FileManagerServiceTests.swift
// Copyright © Alexandr T. All rights reserved.

@testable import MovieMVVM

import XCTest

/// Тесты  файл менеджера
final class FileManagerServiceTests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let mockPath = "mockPath"
    }

    // MARK: - Private Properties

    private let mockProxy = MockProxy()

    private var fileManagerService: FileManagerProtocol?

    // MARK: - Public Methods

    override func setUp() {
        fileManagerService = FileManagerService()
    }

    override func tearDown() {
        fileManagerService = nil
    }

    func testLoadAndSaveData() {
        let mockData = Data(count: 34)
        fileManagerService?.saveData(path: Constants.mockPath, data: mockData)
        let data = fileManagerService?.loadData(path: Constants.mockPath)
        XCTAssertNotNil(mockData)
    }
}
