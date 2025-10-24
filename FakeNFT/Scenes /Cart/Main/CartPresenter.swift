//
//  Untitled 2.swift
//  FakeNFT
//
//  Created by Emil on 09.10.2025.
//

import UIKit

protocol CartPresenterProtocol: AnyObject {
    var nfts: [NFTModel] { get }
    func didTapPayButton()
    func didTapSortButton()
    func viewDidLoad()
    func didSelectSortOption(_ option: SortOption)
    func deleteNFT(_ nft: NFTModel)
}

enum SortOption: String {
    case price
    case rating
    case name
}

final class CartPresenter: CartPresenterProtocol {
    
    private enum Constants {
        static let cartErrorLable = "Cart.error.loading".localized
    }
    
    weak var view: CartViewProtocol?
    private let cartService: CartServiceProtocol
    private let router: CartRouterProtocol
    
    private(set) var nfts: [NFTModel] = []
    
    private let sortOptionKey = "CartSortOption"

    private var currentSortOption: SortOption = .name
    
    init(view: CartViewProtocol?, cartService: CartServiceProtocol = CartService.shared, router: CartRouterProtocol) {
        self.view = view
        self.cartService = cartService
        self.router = router
        
        cartService.delegate = self
    }
    
    func viewDidLoad() {
        reloadCart()
        
        loadSavedSortOption()
    }
    
    private func updateSummary() {
        let count = nfts.count
        let total = nfts.reduce(0) { $0 + $1.price }
        
        let countText = "\(count) NFT"
        let totalText = String(format: "%.2f ETH", total)
        view?.updateSummary(countText: countText, totalText: totalText)
        
        if nfts.isEmpty {
            view?.showEmptyCart()
        } else {
            view?.hideEmptyCart()
        }
    }
    
    func reloadCart() {
        view?.showLoading()
        cartService.loadCartFromServer { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                self.view?.hideLoading()
                switch result {
                case .success:
                    self.cartDidUpdate(self.cartService)
                case .failure(let error):
                    ErrorAlertHelper.showRetryAlert(
                        on: self.view as? UIViewController,
                        message: Constants.cartErrorLable
                    ) { [weak self] in
                        self?.reloadCart()
                    }
                    print("❌ Cart loading error: \(error)")
                }
            }
        }
    }
    
    func didSelectSortOption(_ option: SortOption) {
        currentSortOption = option
        saveSortOption(option)

        applyCurrentSort()
        view?.reloadData()
        updateSummary()
    }
    
    private func applyCurrentSort() {
        switch currentSortOption {
        case .price:
            nfts.sort { $0.price < $1.price }
        case .rating:
            nfts.sort { $0.rating > $1.rating }
        case .name:
            nfts.sort { $0.name < $1.name }
        }
    }
    
    func didTapPayButton() {
        router.openPaymentSelection()
    }
    
    func deleteNFT(_ nft: NFTModel) {
        cartService.removeNFT(nft)
    }
    
    func didTapSortButton() {
        view?.showSortOptions()
    }
}

// MARK: - UserDefaults
private extension CartPresenter {
    func saveSortOption(_ option: SortOption) {
        UserDefaults.standard.set(option.rawValue, forKey: sortOptionKey)
    }

    func loadSavedSortOption() {
        if let saved = UserDefaults.standard.string(forKey: sortOptionKey),
           let option = SortOption(rawValue: saved) {
            currentSortOption = option
        } else {
            currentSortOption = .name
        }
    }
}

extension CartPresenter: CartServiceDelegate {
    func cartDidUpdate(_ cartService: CartServiceProtocol) {
        nfts = cartService.fetchNFTs()
        applyCurrentSort()
        view?.reloadData()
        updateSummary()
        
        if nfts.isEmpty {
            view?.showEmptyCart()
        } else {
            view?.hideEmptyCart()
        }
    }
}
