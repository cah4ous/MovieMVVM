// MoviesViewModel.swift
// Copyright © Alexandr T. All rights reserved.

import Foundation

/// Вью-модель экрана со списком фильмов
final class MoviesViewModel: MoviesViewModelProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let emptyString = ""
    }

    // MARK: - Public Properties

    var movies: [MovieData] = []
    var movie: MovieData?
    var currentCategoryMovies: CategoryMovies = .popular
    var errorCoreDataAlert: AlertHandler?
    var listMoviesState: MoviesStateHandler?
    var uploadApiKeyCompletion: VoidHandler?

    // MARK: - Private Properties

    private var networkService: NetworkServiceProtocol
    private var imageService: LoadImageProtocol
    private var keychainService: KeychainServiceProtocol
    private var coreDataStack: CoreDataServiceProtocol

    // MARK: - Initializers

    init(
        networkService: NetworkServiceProtocol,
        imageService: LoadImageProtocol,
        keychainService: KeychainServiceProtocol,
        coreDataStack: CoreDataServiceProtocol
    ) {
        self.networkService = networkService
        self.imageService = imageService
        self.keychainService = keychainService
        self.coreDataStack = coreDataStack
    }

    // MARK: - Public Methods

    func checkApiKey() {
        guard let apiKey = keychainService.getKey(forKey: KeychainKey.apiKey) else {
            uploadApiKeyCompletion?()
            return
        }
    }

    func uploadApiKey(_ key: String) {
        keychainService.saveKey(key, forKey: .apiKey)
    }

    func fetchData(completion: @escaping DataHandler) {
        guard let movie = movie else { return }
        imageService.loadImage(path: movie.posterPath ?? Constants.emptyString, completion: completion)
    }

    func setupMovie(index: Int) {
        guard index < movies.count else { return }
        movie = movies[index]
    }

    func makeRefresh() {
        listMoviesState?(.loading)
    }

    func fetchMovies() {
        listMoviesState?(.loading)
        networkService.fetchMovies(categoryMovies: currentCategoryMovies) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(movies):
                self.coreDataStack.saveContext(movies: movies, movieCategory: self.currentCategoryMovies)
                self.movies = self.coreDataStack.getData(movieType: self.currentCategoryMovies)
                self.listMoviesState?(.success(self.movies))
            case let .failure(error):
                self.listMoviesState?(.failure(error))
            }
        }
    }

    func loadMovies() {
        listMoviesState?(.loading)
        let movies = coreDataStack.getData(movieType: currentCategoryMovies)
        if !movies.isEmpty {
            self.movies = movies
            listMoviesState?(.success(movies))
        } else {
            fetchMovies()
        }
    }

    func setupCategory(tag: Int) {
        switch tag {
        case 0:
            currentCategoryMovies = .popular
        case 1:
            currentCategoryMovies = .topRated
        case 2:
            currentCategoryMovies = .upcoming
        default:
            break
        }
        listMoviesState?(.loading)
        fetchMovies()
    }
}
