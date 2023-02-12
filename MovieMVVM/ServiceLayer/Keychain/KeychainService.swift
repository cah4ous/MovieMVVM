// KeychainService.swift
// Copyright © Alexandr T. All rights reserved.

import KeychainSwift

/// Keychain сервис
final class KeychainService: KeychainServiceProtocol {
    // MARK: - Public Methods

    func saveKey(_ key: String, forKey: KeychainKey) {
        KeychainSwift().set(key, forKey: forKey.rawValue)
    }

    func getKey(forKey: KeychainKey) -> String? {
        KeychainSwift().get(forKey.rawValue)
    }
}
