// KeychainServiceTests.swift
// Copyright © Alexandr T. All rights reserved.

@testable import MovieMVVM

import XCTest

/// Тест кейчена
final class KeychainServiceTests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let mockKeyValue = "mock"
    }

    // MARK: - Private Properties

    private var keychainService: KeychainServiceProtocol?

    // MARK: - Public Methods

    override func setUp() {
        super.setUp()
        keychainService = KeychainService()
    }

    override func tearDown() {
        super.tearDown()
        keychainService = nil
    }

    func testKeychain() {
        keychainService?.saveKey(Constants.mockKeyValue, forKey: .apiKey)
        let mockValueFromKeychain = keychainService?.getKey(forKey: .apiKey)
        XCTAssertEqual(Constants.mockKeyValue, mockValueFromKeychain)
    }
}
