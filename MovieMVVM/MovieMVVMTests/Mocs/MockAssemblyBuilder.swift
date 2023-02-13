// MockAssemblyBuilder.swift
// Copyright © Alexandr T. All rights reserved.

@testable import MovieMVVM
import UIKit

/// Мок билдера
final class MockAssemblyBuilder: AssemblyBuilderProtocol {
    // MARK: - Public Methods

    func makeMainModule() -> UIViewController {
        UIViewController()
    }

    func makeDetailModule(movie: MovieMVVM.MovieData) -> UIViewController {
        UIViewController()
    }
}
