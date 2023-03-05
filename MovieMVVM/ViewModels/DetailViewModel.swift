// DetailViewModel.swift
// Copyright © Alexandr T. All rights reserved.

import Foundation

/// Вью-модель экрана с выбранным фильмом
final class DetailMovieViewModel: DetailMovieViewModelProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let emptyString = ""
    }

    // MARK: - Public Properties

    var similarMovies: [SimilarMovie] = []
    var movie: MovieData
    var posterPath = Constants.emptyString
    var similarMoviesCompletion: SimilarMoviesHandler?
    var similarPosterCompletion: DataHandler?
    var mainPosterCompletion: DataHandler?

    // MARK: - Private Properties

    private var networkService: NetworkServiceProtocol
    private var imageService: LoadImageProtocol

    // MARK: - Initializers

    init(networkService: NetworkServiceProtocol, imageService: LoadImageProtocol, movie: MovieData) {
        self.networkService = networkService
        self.imageService = imageService
        self.movie = movie
    }

    // MARK: - Public Methods

    func fetchMainPosterData() {
        guard let mainPosterCompletion = mainPosterCompletion else { return }
        imageService.loadImage(path: movie.posterPath ?? Constants.emptyString, completion: mainPosterCompletion)
    }

    func fetchSimilarPosterData() {
        guard let similarPosterCompletion = similarPosterCompletion else { return }
        imageService.loadImage(path: posterPath, completion: similarPosterCompletion)
    }

    func fetchSimilarMovies() {
        guard let similarMoviesCompletion = similarMoviesCompletion else { return }
        networkService.fetchSimilarMovies(idMovie: Int(movie.movieId)) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case let .success(similarMovies):
                    self.similarMovies = similarMovies
                    similarMoviesCompletion(result)
                case .failure:
                    similarMoviesCompletion(result)
                }
            }
        }
    }

    func setupPoster(index: Int) {
        guard index < similarMovies.count else { return }
        posterPath = similarMovies[index].posterPath
    }

    func setupSimilarPosterCompetion(completion: ((Result<Data, Error>) -> Void)?) {
        similarPosterCompletion = completion
    }
}
