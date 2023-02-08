// FileManagerProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол файл менеджера
protocol FileManagerProtocol {
    func loadData(path: String) -> Data?
    func saveData(path: String, data: Data)
}
