// AssemblyBuilderProtocol.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Сборщик модулей
protocol AssemblyBuilderProtocol {
    func makeMainModule() -> UIViewController
    func makeDetailModule(movie: Movie) -> UIViewController
}
