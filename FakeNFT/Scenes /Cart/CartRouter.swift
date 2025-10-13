//
//  CartRouter.swift
//  FakeNFT
//
//  Created by Emil on 13.10.2025.
//

import UIKit

protocol CartRouterProtocol {
    func openPaymentSelection()
}

final class CartRouter: CartRouterProtocol {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
    
    func openPaymentSelection() {
        let paymentVC = PaymentViewController()
        guard let vc = viewController else {print("Penis")
            return }
        guard let navigationController = vc.navigationController else {
            print("xuio")
            return
        }
        navigationController.pushViewController(paymentVC, animated: true)
    }
}
