// SimilarMovie.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Похожий фильм
struct SimilarMovie: Codable {
    // MARK: - Public Properties

    /// Постер похожего письма
    let posterPath: String

    // MARK: - Private Enum

    private enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
    }
}
