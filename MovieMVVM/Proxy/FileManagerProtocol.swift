// FileManagerProtocol.swift
// Copyright © Alexandr T. All rights reserved.

import Foundation

/// Протокол файл менеджера
protocol FileManagerProtocol {
    func loadData(path: String) -> Data?
    func saveData(path: String, data: Data)
}
