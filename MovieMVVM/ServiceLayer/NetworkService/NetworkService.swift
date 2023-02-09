// NetworkService.swift
// Copyright © Alexandr T. All rights reserved.

import Foundation

/// Cервис сетевого слоя
final class NetworkService: NetworkServiceProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let apiKeyQueryText = "api_key="
        static let languageQueryText = "&language=ru-RU"
        static let pageQueryText = "&page=1"
        static let themoviedbQueryText = "https://api.themoviedb.org/3/movie/"
        static let similarQueryText = "/similar?"
        static let topRatedQueryText = "top_rated?"
        static let popularQueryText = "popular?"
        static let upcomingQueryText = "upcoming?"
        static let emptyText = ""
    }

    // MARK: - Private Properties

    private var keychainService: KeychainServiceProtocol

    // MARK: - Initializers

    init(keychainService: KeychainServiceProtocol) {
        self.keychainService = keychainService
    }

    // MARK: - Public Methods

    func fetchMovies(categoryMovies: CategoryMovies, completion: @escaping (Result<[Movie], Error>) -> Void) {
        let urlString = getCategoryURL(categoryMovies: categoryMovies)
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if error == nil {
                guard let data = data else { return }
                do {
                    let decodedData = try JSONDecoder().decode(MovieList.self, from: data).movies
                    DispatchQueue.main.async {
                        completion(.success(decodedData))
                    }
                } catch {
                    completion(.failure(error))
                }
            } else {
                guard let error = error else { return }
                completion(.failure(error))
            }
        }.resume()
    }

    func fetchSimilarMovies(idMovie: Int, completion: @escaping ((Result<[SimilarMovie], Error>) -> Void)) {
        let urlString = getBaseUrl(currentCategoryMovies: "\(idMovie)")
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if error == nil {
                guard let data = data else { return }
                do {
                    let similarMovies = try JSONDecoder().decode(SimilarMovies.self, from: data).results
                    DispatchQueue.main.async {
                        completion(.success(similarMovies))
                    }
                } catch {
                    completion(.failure(error))
                }
            } else {
                guard let error = error else { return }
                completion(.failure(error))
            }
        }.resume()
    }

    func getCategoryURL(categoryMovies: CategoryMovies) -> String {
        var currentCategoryMovies = Constants.emptyText
        switch categoryMovies {
        case .topRated:
            currentCategoryMovies = Constants.topRatedQueryText
        case .popular:
            currentCategoryMovies = Constants.popularQueryText
        case .upcoming:
            currentCategoryMovies = Constants.upcomingQueryText
        }
        let urlString = getBaseUrl(currentCategoryMovies: currentCategoryMovies)
        return urlString
    }

    func getBaseUrl(currentCategoryMovies: String) -> String {
        guard let APIKeyValue = keychainService.getKey(forKey: KeychainKey.apiKey) else { return Constants.emptyText }
        return "\(Constants.themoviedbQueryText)\(currentCategoryMovies)\(Constants.apiKeyQueryText)" +
            "\(APIKeyValue)"
        "\(Constants.languageQueryText)\(Constants.pageQueryText)\(Constants.pageQueryText)"
    }
}
