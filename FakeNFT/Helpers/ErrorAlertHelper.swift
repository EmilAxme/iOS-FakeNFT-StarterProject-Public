//
//  ErrorAlertHelper.swift
//  FakeNFT
//
//  Created by Emil on 24.10.2025.
//

import UIKit

enum ErrorAlertHelper {
    static func showRetryAlert(
        on viewController: UIViewController?,
        title: String = "Network Error",
        message: String,
        retryAction: @escaping () -> Void
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let retry = UIAlertAction(title: "Retry", style: .default) { _ in retryAction() }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancel)
        alert.addAction(retry)
        viewController?.present(alert, animated: true)
    }
}
