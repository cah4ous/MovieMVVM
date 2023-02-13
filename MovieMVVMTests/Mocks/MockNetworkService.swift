// MockNetworkService.swift
// Copyright © Alexandr T. All rights reserved.

@testable import MovieMVVM
import UIKit

/// Мок сетевого слоя
final class MockNetworkService: NetworkServiceProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let emptyString = ""
        static let mockValue = 1.3
        static let movieId = 0
    }

    // MARK: - Public Methods

    var keychainService: KeychainServiceProtocol

    var movie: [Movie]? = [
        Movie(
            movieId: Constants.movieId,
            overview: Constants.emptyString,
            posterPath: Constants.emptyString,
            releaseDate: Constants.emptyString,
            title: Constants.emptyString,
            voteAverage: Constants.mockValue,
            voteCount: Constants.mockValue
        ),
        Movie(
            movieId: Constants.movieId,
            overview: Constants.emptyString,
            posterPath: Constants.emptyString,
            releaseDate: Constants.emptyString,
            title: Constants.emptyString,
            voteAverage: Constants.mockValue,
            voteCount: Constants.mockValue
        )
    ]

    var similarMovies: [SimilarMovie]? = [
        SimilarMovie(posterPath: Constants.emptyString),
        SimilarMovie(posterPath: Constants.emptyString),
    ]

    // MARK: - Initializers

    init(keychainService: KeychainServiceProtocol) {
        self.keychainService = keychainService
    }

    // MARK: - Public Methods

    func fetchMovies(
        categoryMovies: MovieMVVM.CategoryMovies,
        completion: @escaping (Result<[MovieMVVM.Movie], Error>) -> Void
    ) {
        if let movie = movie {
            completion(.success(movie))
        } else {
            let error = NSError(domain: Constants.emptyString, code: .zero)
            completion(.failure(error))
        }
    }

    func fetchSimilarMovies(idMovie: Int, completion: @escaping ((Result<[MovieMVVM.SimilarMovie], Error>) -> Void)) {
        if let similarMovie = similarMovies {
            completion(.success(similarMovie))
        } else {
            let error = NSError(domain: Constants.emptyString, code: .zero)
            completion(.failure(error))
        }
    }
}
