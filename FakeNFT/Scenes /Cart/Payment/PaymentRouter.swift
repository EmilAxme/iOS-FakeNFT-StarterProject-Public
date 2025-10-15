//
//  PaymentRouter.swift
//  FakeNFT
//
//  Created by Emil on 14.10.2025.
//

import UIKit

protocol PaymentRouterProtocol {
    func openPaymentSuccess()
}

final class PaymentRouter: PaymentRouterProtocol {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
    
    func openPaymentSuccess() {
        let successVC = PaymentSuccessViewController()
        viewController?.navigationController?.pushViewController(successVC, animated: true)
    }
}
