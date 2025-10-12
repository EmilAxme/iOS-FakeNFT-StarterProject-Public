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
        view?.reloadData()
    }
}
