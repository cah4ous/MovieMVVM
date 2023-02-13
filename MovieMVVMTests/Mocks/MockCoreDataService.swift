// MockCoreDataService.swift
// Copyright © Alexandr T. All rights reserved.

@testable import MovieMVVM

import CoreData
import XCTest

final class MockCoreDataService: CoreDataServiceProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let mockPosterPath = "mock"
        static let emptyString = ""
        static let mockId = 3
        static let mockDoubleValue = 3.0
        static let entityName = "MovieData"
        static let predicateFormatText = "category = %@"
        static let movieDataModelName = "MovieDataModel"
    }

    // MARK: - Public Properties

    var movies: [Movie]?
    var isSimilarMovieCorrect = false
    var errorCoreDataAlert: AlertHandler?
    lazy var managedContext: NSManagedObjectContext = self.storeContainer.viewContext

    // MARK: - Private Properties

    private let mockMovies = [Movie(
        movieId: Constants.mockId,
        overview: Constants.emptyString,
        posterPath: Constants.emptyString,
        releaseDate: Constants.emptyString,
        title: Constants.emptyString,
        voteAverage: Constants.mockDoubleValue,
        voteCount: Constants.mockDoubleValue
    )]
    private let mockSimilarMovies = [SimilarMovie(posterPath: Constants.mockPosterPath)]

    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Constants.movieDataModelName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                self.errorCoreDataAlert?(error.localizedDescription)
            }
        }
        return container
    }()

    // MARK: - Public Methods

    func saveContext(movies: [MovieMVVM.Movie], movieCategory: MovieMVVM.CategoryMovies) {
        self.movies = movies
    }

    func getData(movieType: MovieMVVM.CategoryMovies) -> [MovieMVVM.MovieData] {
        var movieObjects: [MovieData] = []
        let predicate = NSPredicate(format: Constants.predicateFormatText, movieType.category)
        let fecthRequest: NSFetchRequest<MovieData> = MovieData.fetchRequest()
        fecthRequest.predicate = predicate
        do {
            movieObjects = try managedContext.fetch(fecthRequest)
        } catch let error as NSError {
            errorCoreDataAlert?(error.localizedDescription)
        }
        return movieObjects
    }
}
