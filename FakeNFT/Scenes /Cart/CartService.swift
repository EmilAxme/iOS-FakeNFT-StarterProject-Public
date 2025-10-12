//
//  CartService.swift
//  FakeNFT
//
//  Created by Emil on 12.10.2025.
//

import UIKit

protocol CartServiceProtocol {
    func fetchNFTs() -> [NFTMock]
}

final class MockCartService: CartServiceProtocol {
    func fetchNFTs() -> [NFTMock] {
        return [
            NFTMock(name: "April", price: 1.78, rating: 1, image: UIImage(resource: .nft1)),
            NFTMock(name: "Greena", price: 1.78, rating: 3, image: UIImage(resource: .nft2)),
            NFTMock(name: "Spring", price: 1.78, rating: 5, image: UIImage(resource: .nft3))
        ]
    }
}
