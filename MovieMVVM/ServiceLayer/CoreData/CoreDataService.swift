// CoreDataService.swift
// Copyright © Alexandr T. All rights reserved.

import CoreData

/// Сервис кордаты
final class CoreDataService: CoreDataServiceProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let errorPartText = "Unresolved error "
        static let entityName = "MovieData"
        static let predicateFormatText = "category = %@"
    }

    // MARK: - Public Properties

    lazy var managedContext: NSManagedObjectContext = self.storeContainer.viewContext
    var errorCoreDataAlert: AlertHandler?

    // MARK: - Private Properties

    private let modelName: String

    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                self.errorCoreDataAlert?(error.localizedDescription)
            }
        }
        return container
    }()

    // MARK: - Initializers

    init(modelName: String) {
        self.modelName = modelName
    }

    // MARK: - Public Methods

    func saveContext(movies: [Movie], movieCategory: CategoryMovies) {
        guard let newMovie = NSEntityDescription.entity(forEntityName: Constants.entityName, in: managedContext)
        else { return }
        for movie in movies {
            let newMovie = MovieData(entity: newMovie, insertInto: managedContext)
            newMovie.title = movie.title
            newMovie.overview = movie.overview
            newMovie.voteCount = movie.voteCount
            newMovie.voteAverage = movie.voteAverage
            newMovie.posterPath = movie.posterPath
            newMovie.releaseData = movie.releaseDate
            newMovie.movieId = Int64(movie.movieId)
            newMovie.category = movieCategory.category
            newMovie.id = UUID()
            do {
                try managedContext.save()
            } catch let error as NSError {
                errorCoreDataAlert?(error.localizedDescription)
            }
        }
    }

    func getData(movieType: CategoryMovies) -> [MovieData] {
        var movieObject: [MovieData] = []
        let predicate = NSPredicate(format: Constants.predicateFormatText, movieType.category)
        let fecthRequest: NSFetchRequest<MovieData> = MovieData.fetchRequest()
        fecthRequest.predicate = predicate
        do {
            movieObject = try managedContext.fetch(fecthRequest)
        } catch let error as NSError {
            errorCoreDataAlert?(error.localizedDescription)
        }
        return movieObject
    }
}
