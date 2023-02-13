// MoviesViewModelTests.swift
// Copyright © Alexandr T. All rights reserved.

@testable import MovieMVVM

import XCTest

/// Тесты экрана со списком фильмов
final class MoviesViewModelTests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let mockValue = "mock"
        static let mockPencilText = "pencil"
        static let emptyText = ""
        static let zeroNumberInt = 0
        static let zeroNumberDouble = 0.0
        static let mockNumber = 8
    }

    // MARK: - Private Properties

    private let mockKeychainService = MockKeychainService()
    private let mockNetworkService = MockNetworkService(keychainService: MockKeychainService())
    private let mockCoreDataService = MockCoreDataService()
    private let mockImageService = MockImageService()
    private let mockMovies = [Movie(
        movieId: 0,
        overview: "",
        posterPath: "",
        releaseDate: "",
        title: "",
        voteAverage: 3.0,
        voteCount: 3.0
    )]
    private let mockMovie = Movie(
        movieId: 0,
        overview: "",
        posterPath: "",
        releaseDate: "",
        title: "",
        voteAverage: 3.0,
        voteCount: 3.0
    )

    private var listMoviesViewModel: MoviesViewModelProtocol?
    private var mockProps: ListMoviesState?

    // MARK: - Public Methods

    override func setUp() {
        listMoviesViewModel = MoviesViewModel(
            networkService: mockNetworkService,
            imageService: mockImageService,
            keychainService: mockKeychainService,
            coreDataStack: mockCoreDataService
        )
    }

    override func tearDown() {
        listMoviesViewModel = nil
        mockProps = nil
    }

    func testFetchMovies() {
        var loading = false
        listMoviesViewModel?.listMoviesState = { [weak self] states in
            guard let self = self else { return }
            switch states {
            case .initial:
                XCTAssertTrue(false)
            case .loading:
                loading = true
            case let .success(movies):
                XCTAssertNotNil(movies)
            case let .failure(error):
                XCTAssertNotNil(error)
            }
        }
        listMoviesViewModel?.fetchMovies()
        XCTAssertTrue(loading)
        XCTAssertNotNil(mockCoreDataService.movies)
        guard let movies = mockCoreDataService.movies else { return }
        XCTAssertEqual(movies.first?.movieId, mockMovies.first?.movieId)
    }

    func testFetchData() {
        listMoviesViewModel?.fetchData { result in
            switch result {
            case let .success(mockData):
                let data = Data(count: Constants.mockNumber)
                XCTAssertEqual(mockData, data)
            case let .failure(error):
                XCTAssertNotNil(error)
            }
        }
    }

    func testSetupCategory() {
        listMoviesViewModel?.setupCategory(tag: 0)
        XCTAssertEqual(listMoviesViewModel?.currentCategoryMovies, .popular)
        listMoviesViewModel?.setupCategory(tag: 1)
        XCTAssertEqual(listMoviesViewModel?.currentCategoryMovies, .topRated)
        listMoviesViewModel?.setupCategory(tag: 2)
        XCTAssertEqual(listMoviesViewModel?.currentCategoryMovies, .upcoming)
    }
}
