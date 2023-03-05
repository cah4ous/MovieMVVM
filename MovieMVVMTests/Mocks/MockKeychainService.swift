// MockKeychainService.swift
// Copyright © Alexandr T. All rights reserved.

@testable import MovieMVVM

import XCTest

/// Мок кейчейн сервиса
final class MockKeychainService: KeychainServiceProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let mockText = "mock"
    }

    // MARK: - Public Properties

    var apiKey: String?

    // MARK: - Public Methods

    func saveKey(_ key: String, forKey: MovieMVVM.KeychainKey) {
        apiKey = key
    }

    func getKey(forKey: MovieMVVM.KeychainKey) -> String? {
        Constants.mockText
    }
}
