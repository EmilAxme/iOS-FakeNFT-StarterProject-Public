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
        let paymentPresenter = PaymentPresenter(view: paymentVC)
        paymentVC.presenter = paymentPresenter
        
        paymentVC.hidesBottomBarWhenPushed = true
        
        guard let navigationController = viewController?.navigationController else {
            print("❌ Нет navigationController у \(String(describing: viewController))")
            return
        }
        navigationController.pushViewController(paymentVC, animated: true)
    }
}
