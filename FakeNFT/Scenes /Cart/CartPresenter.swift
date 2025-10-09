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
    private(set) var nfts: [NFTMock] = []
    
    init(view: CartViewProtocol?) {
        self.view = view
    }
    
    func viewDidLoad() {
        nfts = [
            NFTMock(name: "April", price: 1.78, rating: 1, image: UIImage(resource: .nft1)),
            NFTMock(name: "Greena", price: 1.78, rating: 3, image: UIImage(resource: .nft2)),
            NFTMock(name: "Spring", price: 1.78, rating: 5, image: UIImage(resource: .nft3))
        ]
        view?.reloadData()
    }
}
