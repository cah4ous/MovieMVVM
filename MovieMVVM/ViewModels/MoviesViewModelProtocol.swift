// MoviesViewModelProtocol.swift
// Copyright © Alexandr T. All rights reserved.

import Foundation

/// Протокол вью-модель экрана со списком фильмов
protocol MoviesViewModelProtocol {
    // MARK: - Public Properties

    var uploadApiKeyCompletion: VoidHandler? { get set }
    var movies: [MovieData] { get set }
    var movie: MovieData? { get set }
    var currentCategoryMovies: CategoryMovies { get set }
    var listMoviesState: MoviesStateHandler? { get set }

    // MARK: - Public Methods

    func uploadApiKey(_ key: String)
    func loadMovies()
    func checkApiKey()
    func fetchMovies()
    func fetchData(completion: @escaping DataHandler)
    func setupMovie(index: Int)
    func makeRefresh()
    func setupCategory(tag: Int)
}
