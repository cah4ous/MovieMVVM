// LoadImageProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол загрузки изображений
protocol LoadImageProtocol {
    func loadImage(path: String, completion: @escaping ((Result<Data, Error>) -> Void))
}
