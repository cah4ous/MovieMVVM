// UIViewController+Extension.swift
// Copyright © Alexandr T. All rights reserved.

import UIKit

/// Добавление Alert
extension UIViewController {
    // MARK: - Public Methods

    func showErrorAlert(alertTitle: String?, message: String?, actionTitle: String?) {
        let errorAlertController = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        let okErrorAlertControllerAction = UIAlertAction(title: actionTitle, style: .cancel)
        errorAlertController.addAction(okErrorAlertControllerAction)
        present(errorAlertController, animated: true)
    }

    func showAlert(title: String, message: String, actionTitle: String, completion: @escaping (String) -> Void) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let alertAction = UIAlertAction(title: actionTitle, style: .default) { _ in
            guard let key = alertController.textFields?.first?.text else { return }
            completion(key)
        }
        alertController.addTextField()
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }

    func showAlertController(
        alertTitle: String?,
        alertMessage: String?,
        alertActionTitle: String?,
        handler: ((UIAlertAction) -> ())?
    ) {
        let alertController = UIAlertController(
            title: alertTitle,
            message: alertMessage,
            preferredStyle: .alert
        )
        let alertControllerAction = UIAlertAction(
            title: alertActionTitle,
            style: .default,
            handler: handler
        )
        alertController.addAction(alertControllerAction)
        present(alertController, animated: true)
    }
}
