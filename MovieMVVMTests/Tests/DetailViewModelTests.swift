// DetailViewModelTests.swift
// Copyright © Alexandr T. All rights reserved.

@testable import MovieMVVM

import CoreData
import XCTest

/// Тесты детейл вью модели
final class DetailViewModelTests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let mockString = "Bar"
        static let entityName = "MovieData"
        static let predicateFormatText = "category = %@"
        static let mockNumber = 3
    }

    // MARK: - Public Properties

    lazy var managedContext: NSManagedObjectContext = self.storeContainer.viewContext

    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MovieDataModel")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print(error.localizedDescription)
            }
        }
        return container
    }()

    // MARK: - Private Properties

    private let mockImageService = MockImageService()
    private let mockNetworkService = MockNetworkService(keychainService: MockKeychainService())
    private var detailMovieViewModel: DetailMovieViewModelProtocol?

    // MARK: - Public Methods

    override func setUp() {
        super.setUp()
        guard let newMovie = NSEntityDescription.entity(forEntityName: Constants.entityName, in: managedContext)
        else { return }
        let film = MovieData(entity: newMovie, insertInto: managedContext)
        detailMovieViewModel = DetailMovieViewModel(
            networkService: mockNetworkService,
            imageService: mockImageService,
            movie: film
        )
    }

    override func tearDown() {
        super.tearDown()
        detailMovieViewModel = nil
    }

    func testFetchImage() {
        detailMovieViewModel?.setupSimilarPosterCompetion(completion: { result in
            switch result {
            case let .success(mockData):
                let data = Data(count: Constants.mockNumber)
                XCTAssertEqual(mockData, data)
            case let .failure(error):
                XCTAssertNotNil(error)
            }
        })
    }
}
