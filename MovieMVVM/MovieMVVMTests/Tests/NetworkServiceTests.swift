// NetworkServiceTests.swift
// Copyright © Alexandr T. All rights reserved.

@testable import MovieMVVM
import XCTest

/// Тесты сетевого слоя
final class NetworkServiceTests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let mockApiKey = "mockKey"
    }

    // MARK: - Public Properties

    var movies: [Movie] = []
    var similarMovies: [SimilarMovie] = []

    // MARK: - Private Properties

    private var networkService: NetworkServiceProtocol?

    // MARK: - Public Methods

    override func setUp() {
        networkService = NetworkService(keychainService: KeychainService())
    }

    override func tearDown() {
        networkService = nil
    }

    // MARK: - Public Methods

    func testFetchMovies() {
        let expectation = XCTestExpectation(description: "")
//        networkService?.setupAPIKey(Constants.mockApiKey)
        networkService?.fetchMovies(categoryMovies: .popular) { [weak self] mockResult in
            guard let self = self else { return }
            switch mockResult {
            case let .success(success):
//                self.movies = success
                print("234")
                XCTAssertNotNil(self.movies)
            case let .failure(failure):
                XCTAssertNotNil(failure)
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testFetchSimularMovies() {
        let expectation = XCTestExpectation(description: "")
//        networkService?.setupAPIKey(Constants.mockApiKey)
        networkService?.fetchSimilarMovies(idMovie: 3) { [weak self] mockResult in
            guard let self = self else { return }
            switch mockResult {
            case let .success(success):
                self.similarMovies = success
                print(self.similarMovies)
                XCTAssertNotNil(self.similarMovies)
            case let .failure(failure):
                XCTAssertNotNil(failure)
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
