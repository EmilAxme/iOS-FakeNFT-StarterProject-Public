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
    func selectCurrency(at index: Int)
}

final class PaymentPresenter: PaymentPresenterProtocol {
    weak var view: PaymentViewController?
    private let router: PaymentRouterProtocol
    private let cartService: CartServiceProtocol
    private let currencyService: CurrencyServiceProtocol
    private let paymentService: PaymentServiceProtocol
    
    var currencies: [CurrencyModel] = []
    private var hasFailedOnce = false
    private var selectedCurrencyId: String?
    
    init(view: PaymentViewController?, cartService: CartServiceProtocol = CartService.shared, router: PaymentRouterProtocol, currencyService: CurrencyServiceProtocol = CurrencyService(), paymentService: PaymentServiceProtocol = PaymentService()) {
        self.view = view
        self.router = router
        self.cartService = cartService
        self.currencyService = currencyService
        self.paymentService = paymentService
    }
    
    func viewDidLoad() {
        view?.showLoading()
        loadCurrencies()
        view?.reloadData()
    }
    
    private func loadCurrencies() {
        currencyService.loadCurrencies { [weak self] result in
            guard let self else { return }
            view?.showLoading()
            switch result {
            case .success(let currencies):
                self.currencies = currencies
                self.view?.reloadData()
                self.view?.hideLoading()
            case .failure(let error):
                print("❌ Ошибка загрузки валют: \(error.localizedDescription)")
                self.view?.showPaymentErrorAlert()
            }
        }
    }
    
    func didTapPayButton() {
        guard let selectedId = selectedCurrencyId else {
            print("❌ Валюта не выбрана")
            return
        }

        view?.showLoading()
        paymentService.pay(with: selectedId) { [weak self] result in
            guard let self else { return }
            self.view?.hideLoading()

            switch result {
            case .success(let response):
                if response.success {
                    print("✅ Оплата прошла успешно валютой ID: \(response.id)")
                    self.router.openPaymentSuccess()
                    self.cartService.clearCart()
                } else {
                    self.view?.showPaymentErrorAlert()
                }
            case .failure(let error):
                print("❌ Ошибка оплаты: \(error.localizedDescription)")
                self.view?.showPaymentErrorAlert()
            }
        }
    }
    
    func selectCurrency(at index: Int) {
        selectedCurrencyId = currencies[index].id
    }
}

