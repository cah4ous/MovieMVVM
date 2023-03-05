// SceneDelegate.swift
// Copyright © Alexandr T. All rights reserved.

import UIKit

/// SceneDelegate
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK: - Public Properties

    var window: UIWindow?
    var coordinator: ApplicationCoordinator?

    // MARK: - Public Methods

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            coordinator = ApplicationCoordinator(window: window)
            coordinator?.start()
        }
    }
}
