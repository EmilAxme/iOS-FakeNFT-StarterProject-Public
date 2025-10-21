//
//  Untitled 2.swift
//  FakeNFT
//
//  Created by Emil on 09.10.2025.
//

import Foundation

protocol CartPresenterProtocol: AnyObject {
    var nfts: [NFTMock] { get }
    func didTapPayButton()
    func didTapSortButton()
    func viewDidLoad()
    func didSelectSortOption(_ option: SortOption)
    func deleteNFT(_ nft: NFTMock)
}

enum SortOption: String {
    case price
    case rating
    case name
}

final class CartPresenter: CartPresenterProtocol {
    weak var view: CartViewProtocol?
    private let cartService: CartServiceProtocol
    private let router: CartRouterProtocol
    
    private(set) var nfts: [NFTMock] = []
    
    private let sortOptionKey = "CartSortOption"

    private var currentSortOption: SortOption = .name
    
    init(view: CartViewProtocol?, cartService: CartServiceProtocol = CartService.shared, router: CartRouterProtocol) {
        self.view = view
        self.cartService = cartService
        self.router = router
        
        cartService.delegate = self
    }
    
    func viewDidLoad() {
        nfts = cartService.fetchNFTs()
        
        loadSavedSortOption()
        applyCurrentSort()
        updateSummary()
        view?.reloadData()
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
    
    func deleteNFT(_ nft: NFTMock) {
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
        view?.reloadData()
        updateSummary()
    }
}
