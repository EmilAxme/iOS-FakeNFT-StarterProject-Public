//
//  PaymentPresenter.swift
//  FakeNFT
//
//  Created by Emil on 13.10.2025.
//

import UIKit

protocol PaymentPresenterProtocol: AnyObject {
    var currencies: [CurrencyModel] { get }
    func viewDidLoad()
    func didTapPayButton()
}

final class PaymentPresenter: PaymentPresenterProtocol {
    weak var view: PaymentViewController?
    private let router: PaymentRouterProtocol
    private let cartService: CartServiceProtocol
    private let currencyService: CurrencyServiceProtocol
    
    var currencies: [CurrencyModel] = []

    private var hasFailedOnce = false
    
    init(view: PaymentViewController?, cartService: CartServiceProtocol = CartService.shared, router: PaymentRouterProtocol, currencyService: CurrencyServiceProtocol = CurrencyService()) {
        self.view = view
        self.router = router
        self.cartService = cartService
        self.currencyService = currencyService
    }
    
    func viewDidLoad() {
        view?.reloadData()
    }
    
    func didTapPayButton() {
        if !hasFailedOnce {
            hasFailedOnce = true
            view?.showPaymentErrorAlert()
        } else {
            // Со второго раза будет успех и покажет экран успеха
            router.openPaymentSuccess()
            cartService.clearCart()
            hasFailedOnce = false
        }
    }
}

