// NetworkService.swift
// Copyright © Alexandr T. All rights reserved.

import Foundation

/// Cервис сетевого слоя
final class NetworkService: NetworkServiceProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let apiKeyQueryText = "api_key="
        static let languageText = "&language=ru-RU"
        static let languageQueryValue = "language"
        static let languageQueryKey = "ru-RU"
        static let pageQueryText = "&page=1"
        static let pageKey = "page"
        static let pageValue = "1"
        static let APIKey = "api_key"
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
        guard let APIKeyValue = keychainService.getKey(forKey: KeychainKey.apiKey) else { return }
        let currentMoviesString = getCategoryURL(categoryMovies: categoryMovies)
        guard var urlComponents = URLComponents(string: "\(Constants.themoviedbQueryText)\(currentMoviesString)")
        else { return }
        urlComponents.queryItems = [
            URLQueryItem(name: Constants.APIKey, value: APIKeyValue),
            URLQueryItem(name: Constants.languageQueryKey, value: Constants.languageQueryValue),
            URLQueryItem(name: Constants.pageKey, value: Constants.pageValue)
        ]
        guard let url = urlComponents.url else { return }
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

    func getBaseUrl(currentCategoryMovies: String) -> String {
        guard let APIKeyValue = keychainService.getKey(forKey: KeychainKey.apiKey) else { return Constants.emptyText }
        return "\(Constants.themoviedbQueryText)\(currentCategoryMovies)\(Constants.apiKeyQueryText)" +
            "\(APIKeyValue)"
        "\(Constants.languageText)\(Constants.pageQueryText)\(Constants.pageQueryText)"
    }

    // MARK: - Private Methods

    private func getCategoryURL(categoryMovies: CategoryMovies) -> String {
        var currentCategoryMovies = getCategoryString(categoryMovies: categoryMovies)
        let urlString = getBaseUrl(currentCategoryMovies: currentCategoryMovies)
        return urlString
    }
    
    private func getCategoryString(categoryMovies: CategoryMovies) -> String {
        switch categoryMovies {
        case .topRated:
            return Constants.topRatedQueryText
        case .popular:
            return Constants.popularQueryText
        case .upcoming:
            return Constants.upcomingQueryText
        }
    }
}
