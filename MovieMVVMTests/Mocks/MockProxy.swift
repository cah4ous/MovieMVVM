// MockProxy.swift
// Copyright © Alexandr T. All rights reserved.

@testable import MovieMVVM

import XCTest

/// Мок прокси
final class MockProxy: ProxyProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let mockPath = "mockPath"
        static let mockNumber = 34
    }

    // MARK: - Public Methods

    func loadImage(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        if Constants.mockPath == url {
            let data = Data(count: Constants.mockNumber)
            completion(.success(data))
        }
    }
}
