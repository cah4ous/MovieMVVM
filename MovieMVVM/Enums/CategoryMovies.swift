// CategoryMovies.swift
// Copyright © Alexandr T. All rights reserved.

import Foundation

/// Категории фильмов
enum CategoryMovies {
    case topRated
    case popular
    case upcoming

    var category: String {
        switch self {
        case .popular:
            return "popular"
        case .topRated:
            return "top_rated"
        case .upcoming:
            return "upcoming"
        }
    }
}
