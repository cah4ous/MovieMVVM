// MockNetworkService.swift
// Copyright © Alexandr T. All rights reserved.

@testable import MovieMVVM
import UIKit

/// Мок сетевого сервиса
final class MockNetworkService: NetworkServiceProtocol {
    // MARK: - Public Properties

    var apiKey: String?

    var movie: [Movie]? = [
        Movie(movieId: 0, overview: "", posterPath: "", releaseDate: "", title: "", voteAverage: 1.3, voteCount: 2.3),
        Movie(movieId: 0, overview: "", posterPath: "", releaseDate: "", title: "", voteAverage: 1.3, voteCount: 2.3),
        Movie(movieId: 0, overview: "", posterPath: "", releaseDate: "", title: "", voteAverage: 1.3, voteCount: 2.3),
        Movie(movieId: 0, overview: "", posterPath: "", releaseDate: "", title: "", voteAverage: 1.3, voteCount: 2.3),
    ]

    var similarMovies: [SimilarMovie]? = [
        SimilarMovie(posterPath: ""),
        SimilarMovie(posterPath: ""),
    ]

    // MARK: - Public Methods

    func setupAPIKey(_ apiKey: String) {
        self.apiKey = apiKey
    }

    func fetchMovies(
        categoryMovies: MovieMVVM.CategoryMovies,
        completion: @escaping (Result<[Movie], Error>) -> Void
    ) {
        if let movie = movie {
            completion(.success(movie))
        } else {
            let error = NSError(domain: "", code: .zero)
            completion(.failure(error))
        }
    }

    func fetchSimilarMovies(idMovie: Int, completion: @escaping ((Result<[SimilarMovie], Error>) -> Void)) {
        if let similarMovie = similarMovies {
            completion(.success(similarMovie))
        } else {
            let error = NSError(domain: "", code: .zero)
            completion(.failure(error))
        }
    }
}
