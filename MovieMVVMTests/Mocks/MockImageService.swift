// MockImageService.swift
// Copyright © Alexandr T. All rights reserved.

@testable import MovieMVVM

import XCTest

/// Мок сервиса изображений
final class MockImageService: LoadImageProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let mockPath = "mockPath"
        static let mockValue = 30
    }

    // MARK: - Public Methods

    func loadImage(path: String, completion: @escaping ((Result<Data, Error>) -> Void)) {
        if path == Constants.mockPath {
            let data = Data(count: Constants.mockValue)
            completion(.success(data))
        }
    }
}
