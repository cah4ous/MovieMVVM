// ModuleBuilder.swift
// Copyright © Alexandr T. All rights reserved.

import UIKit

/// Сборщик экранов
final class ModuleBuilder: AssemblyBuilderProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let coreDataModelName = "MovieDataModel"
    }

    // MARK: - Public Methods

    func makeMainModule() -> UIViewController {
        let keychainService = KeychainService()
        let networkService = NetworkService(keychainService: keychainService)
        let imageAPIService = ImageAPIService()
        let fileManagerService = FileManagerService()
        let coreDataStack = CoreDataService(modelName: Constants.coreDataModelName)
        let proxy = Proxy(
            fileManager: fileManagerService,
            imageAPIService: imageAPIService
        )
        let imageService = ImageService(proxy: proxy)
        let viewModel = MoviesViewModel(
            networkService: networkService,
            imageService: imageService,
            keychainService: keychainService,
            coreDataStack: coreDataStack
        )
        let view = MoviesViewController(movieViewModel: viewModel)
        return view
    }

    func makeDetailModule(movie: MovieData) -> UIViewController {
        let keychainService = KeychainService()
        let networkService = NetworkService(keychainService: keychainService)
        let fileManagerService = FileManagerService()
        let imageAPIService = ImageAPIService()
        let proxy = Proxy(fileManager: fileManagerService, imageAPIService: imageAPIService)
        let imageService = ImageService(proxy: proxy)
        let detailMovieViewModel = DetailMovieViewModel(
            networkService: networkService,
            imageService: imageService,
            movie: movie
        )
        let detailMovieViewController = DetailViewController(detailViewModel: detailMovieViewModel)
        return detailMovieViewController
    }
}
