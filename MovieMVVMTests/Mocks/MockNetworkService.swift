// MockNetworkService.swift
// Copyright © Alexandr T. All rights reserved.

@testable import MovieMVVM
import UIKit

/// Мок сетевого слоя
final class MockNetworkService: NetworkServiceProtocol {
    var keychainService: KeychainServiceProtocol

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

    init(keychainService: KeychainServiceProtocol) {
        self.keychainService = keychainService
    }

    func fetchMovies(
        categoryMovies: MovieMVVM.CategoryMovies,
        completion: @escaping (Result<[MovieMVVM.Movie], Error>) -> Void
    ) {
        if let movie = movie {
            completion(.success(movie))
        } else {
            let error = NSError(domain: "", code: .zero)
            completion(.failure(error))
        }
    }

    func fetchSimilarMovies(idMovie: Int, completion: @escaping ((Result<[MovieMVVM.SimilarMovie], Error>) -> Void)) {
        if let similarMovie = similarMovies {
            completion(.success(similarMovie))
        } else {
            let error = NSError(domain: "", code: .zero)
            completion(.failure(error))
        }
    }
}
