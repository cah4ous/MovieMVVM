// KeychainServiceProtocol.swift
// Copyright © Alexandr T. All rights reserved.

import Foundation

/// Протокол Keychain сервис
protocol KeychainServiceProtocol {
    func saveKey(_ key: String, forKey: KeychainKey)
    func getKey(forKey: KeychainKey) -> String?
}
