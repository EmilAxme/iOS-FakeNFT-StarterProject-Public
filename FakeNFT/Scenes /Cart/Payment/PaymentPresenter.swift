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
    var currencies: [CurrencyModel] = []
    
    private var hasFailedOnce = false
    
    init(view: PaymentViewController?, cartService: CartServiceProtocol = CartService.shared, router: PaymentRouterProtocol) {
        self.view = view
        self.router = router
        self.cartService = cartService
    }
    
    func viewDidLoad() {
        currencies = [
            CurrencyModel(name: "Bitcoin", ticker: "BTC", icon: UIImage(resource: .bitcoin)),
            CurrencyModel(name: "Dogecoin", ticker: "DOGE", icon: UIImage(resource: .dogecoin)),
            CurrencyModel(name: "Tether", ticker: "USDT", icon: UIImage(resource: .tether)),
            CurrencyModel(name: "Apecoin", ticker: "APE", icon: UIImage(resource: .apecoin)),
            CurrencyModel(name: "Solana", ticker: "SOL", icon: UIImage(resource: .solana)),
            CurrencyModel(name: "Ethereum", ticker: "ETH", icon: UIImage(resource: .ethereum)),
            CurrencyModel(name: "Cardano", ticker: "ADA", icon: UIImage(resource: .cardano)),
            CurrencyModel(name: "Shiba Inu", ticker: "SHIB", icon: UIImage(resource: .shibaInu))]
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

