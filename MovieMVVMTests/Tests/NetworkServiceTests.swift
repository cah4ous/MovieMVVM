// NetworkServiceTests.swift
// Copyright © Alexandr T. All rights reserved.

@testable import MovieMVVM
import XCTest

/// Тесты сетевого слоя
final class NetworkServiceTests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let emptyString = ""
        static let maxTimeSecondsValue = 10.0
        static let defaultFilmId = 3
    }

    // MARK: - Private Properties

    private var networkService: NetworkServiceProtocol?

    // MARK: - Public Methods

    override func setUp() {
        super.setUp()
        networkService = NetworkService(keychainService: KeychainService())
    }

    override func tearDown() {
        super.tearDown()
        networkService = nil
    }

    func testFetchMovies() {
        let expectation = XCTestExpectation(description: Constants.emptyString)
        networkService?.fetchMovies(categoryMovies: .popular) { mockResult in
            switch mockResult {
            case let .success(success):
                expectation.fulfill()
                XCTAssertNotNil(success)
            case let .failure(failure):
                expectation.fulfill()
                XCTAssertNotNil(failure)
            }
        }
        wait(for: [expectation], timeout: Constants.maxTimeSecondsValue)
    }

    func testFetchSimularMovies() {
        let expectation = XCTestExpectation(description: Constants.emptyString)
        networkService?.fetchSimilarMovies(idMovie: Constants.defaultFilmId) { mockResult in
            switch mockResult {
            case let .success(success):
                expectation.fulfill()
                XCTAssertNotNil(success)
            case let .failure(failure):
                expectation.fulfill()
                XCTAssertNotNil(failure)
            }
        }
        wait(for: [expectation], timeout: Constants.maxTimeSecondsValue)
    }
}
