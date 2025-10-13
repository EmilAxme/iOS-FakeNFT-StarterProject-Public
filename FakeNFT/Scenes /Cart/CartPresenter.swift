//
//  Untitled 2.swift
//  FakeNFT
//
//  Created by Emil on 09.10.2025.
//

import Foundation
import UIKit

protocol CartViewProtocol: AnyObject {
    func reloadData()
    func updateSummary(countText: String, totalText: String)
}

protocol CartPresenterProtocol: AnyObject {
    var nfts: [NFTMock] { get }
    func viewDidLoad()
}

final class CartPresenter: CartPresenterProtocol {
    weak var view: CartViewProtocol?
    private let cartService: CartServiceProtocol
    private(set) var nfts: [NFTMock] = []
    
    init(view: CartViewProtocol?, cartService: CartServiceProtocol) {
        self.view = view
        self.cartService = cartService
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
}
