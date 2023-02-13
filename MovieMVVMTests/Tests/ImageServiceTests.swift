// ImageServiceTests.swift
// Copyright © Alexandr T. All rights reserved.

@testable import MovieMVVM

import XCTest

/// Тесты файл менеджера
final class ImageServiceTests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let mockPathString = "mock"
    }

    // MARK: - Private Properties

    private var imageService: LoadImageProtocol?

    // MARK: - Public Methods

    override func setUp() {
        super.setUp()
        imageService = ImageAPIService()
    }

    override func tearDown() {
        super.tearDown()
        imageService = nil
    }

    func testLoadImage() {
        imageService?.loadImage(path: Constants.mockPathString, completion: { result in
            switch result {
            case let .success(data):
                XCTAssertNotNil(data)
            case let .failure(error):
                XCTFail(error.localizedDescription)
            }
        })
    }
}
