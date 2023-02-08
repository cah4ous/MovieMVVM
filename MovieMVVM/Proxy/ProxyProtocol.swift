// ProxyProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол прокси
protocol ProxyProtocol {
    func loadImage(url: String, completion: @escaping (Result<Data, Error>) -> Void)
}
