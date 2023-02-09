// KeychainServiceProtocol.swift
// Copyright © Alexandr T. All rights reserved.

import Foundation

/// Протокол Keychain сервис
protocol KeychainServiceProtocol {
    // MARK: - Public Methods

    func saveKey(_ key: String, forKey: KeychainKey)
    func getKey(forKey: KeychainKey) -> String?
}
