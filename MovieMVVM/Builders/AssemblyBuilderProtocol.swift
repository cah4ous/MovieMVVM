// AssemblyBuilderProtocol.swift
// Copyright © Alexandr T. All rights reserved.

import UIKit

/// Сборщик модулей
protocol AssemblyBuilderProtocol {
    func makeMainModule() -> UIViewController
    func makeDetailModule(movie: MovieData) -> UIViewController
}
