// MovieList.swift
// Copyright © Alexandr T. All rights reserved.

import Foundation

/// Список фильмов
struct MovieList: Codable {
    // MARK: - Public Properties

    /// Номер страницы с набором фильмов
    let page: Int
    /// Массив с фильмами
    let movies: [Movie]
    /// Общее количество страниц
    let totalPages: Int
    /// Общее количество фильмов
    let totalResults: Int

    // MARK: - Private Enum

    private enum CodingKeys: String, CodingKey {
        case page
        case movies = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
