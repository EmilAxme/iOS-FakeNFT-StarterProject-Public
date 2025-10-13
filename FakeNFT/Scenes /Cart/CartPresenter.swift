//
//  Untitled 2.swift
//  FakeNFT
//
//  Created by Emil on 09.10.2025.
//

import Foundation
import UIKit

protocol CartPresenterProtocol: AnyObject {
    var nfts: [NFTMock] { get }
    func didTapPayButton()
    func didTapSortButton()
    func viewDidLoad()
    func didSelectSortOption(_ option: SortOption)
}

enum SortOption {
    case price
    case rating
    case name
}

final class CartPresenter: CartPresenterProtocol {
    weak var view: CartViewProtocol?
    private let cartService: CartServiceProtocol
    private let router: CartRouterProtocol
    
    private(set) var nfts: [NFTMock] = []
    
    init(view: CartViewProtocol?, cartService: CartServiceProtocol, router: CartRouterProtocol) {
        self.view = view
        self.cartService = cartService
        self.router = router
    }
    
    func viewDidLoad() {
        nfts = cartService.fetchNFTs()
        updateSummary()
        view?.reloadData()
    }
    
    private func updateSummary() {
        let count = nfts.count
        let total = nfts.reduce(0) { $0 + $1.price }
        
        let countText = "\(count) NFT"
        let totalText = String(format: "%.2f ETH", total)
        view?.updateSummary(countText: countText, totalText: totalText)
    }
    
    func didSelectSortOption(_ option: SortOption) {
        switch option {
        case .price:
            nfts.sort { $0.price < $1.price }
        case .rating:
            nfts.sort { $0.rating > $1.rating }
        case .name:
            nfts.sort { $0.name < $1.name }
        }
        view?.reloadData()
        updateSummary()
    }
    
    func didTapPayButton() {
        router.openPaymentSelection()
    }
    
    func didTapSortButton() {
        view?.showSortOptions()
    }
}
