// MovieCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор потока информации о фильмах
final class MovieCoordinator: BaseCoordinator {
    // MARK: - Public Properties

    var onFinishFlow: (() -> ())?

    // MARK: - Private Properties

    private var rootController: UINavigationController?

    // MARK: - Public Methods

    override func start() {
        showMainModule()
    }

    // MARK: - Private Methods

    private func showMainModule() {
        let controller = ModuleBuilder().makeMainModule()
        guard let controller = controller as? MoviesViewController else { return }

        controller.toDetailMovie = { [weak self] movie in
            let detailMovieViewController = ModuleBuilder().build(movie: movie)
            self?.rootController?.pushViewController(detailMovieViewController, animated: false)
        }

        controller.onFinishFlow = { [weak self] in
            self?.onFinishFlow?()
        }

        rootController = UINavigationController(rootViewController: controller)
        guard let rootController = rootController else { return }
        setAsRoot(rootController)
    }
}
