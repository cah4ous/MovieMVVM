// DetailViewModelProtocol.swift
// Copyright © Alexandr T. All rights reserved.

import Foundation

/// Протокол вью-модели экрана с выбранным фильмом
protocol DetailMovieViewModelProtocol {
    // MARK: - Public Properties

    var similarMovies: [SimilarMovie] { get }
    var movie: MovieData { get }
    var posterPath: String { get }
    var similarMoviesCompletion: SimilarMoviesHandler? { get set }
    var similarPosterCompletion: DataHandler? { get set }
    var mainPosterCompletion: DataHandler? { get set }

    // MARK: - Public Methods

    func fetchMainPosterData()
    func fetchSimilarPosterData()
    func setupSimilarPosterCompetion(completion: DataHandler?)
    func fetchSimilarMovies()
    func setupPoster(index: Int)
}
