//
//  CartService.swift
//  FakeNFT
//
//  Created by Emil on 12.10.2025.
//

import UIKit

protocol CartServiceDelegate: AnyObject {
    func cartDidUpdate(_ cartService: CartServiceProtocol)
}

protocol CartServiceProtocol: AnyObject {
    var nfts: [NFTMock] { get }
    var delegate: CartServiceDelegate? { get set }
    
    func fetchNFTs() -> [NFTMock]
    func addNFT(_ nft: NFTMock)
    func removeNFT(_ nft: NFTMock)
    func clearCart()
}

extension Notification.Name {
    static let cartDidUpdate = Notification.Name("cartDidUpdate")
}

final class CartService: CartServiceProtocol {
    
    weak var delegate: CartServiceDelegate?
    
    static let shared = CartService() 
    
    private(set) var nfts: [NFTMock] = [
        NFTMock(name: "April", price: 1.78, rating: 1, image: UIImage(resource: .nft1)),
        NFTMock(name: "Greena", price: 1.78, rating: 3, image: UIImage(resource: .nft2)),
        NFTMock(name: "Spring", price: 1.78, rating: 5, image: UIImage(resource: .nft3))
    ] {
        didSet { delegate?.cartDidUpdate(self) }
    }
    
    private init() {}
    
    func fetchNFTs() -> [NFTMock] {
        return nfts
    }
    
    func removeNFT(_ nft: NFTMock) {
        nfts.removeAll { $0.name == nft.name }
        postUpdateNotification()
    }
    
    func addNFT(_ nft: NFTMock) {
        guard !nfts.contains(where: { $0.name == nft.name }) else { return }
        nfts.append(nft)
        postUpdateNotification()
    }
    
    func clearCart() {
        nfts.removeAll()
        postUpdateNotification()
    }
    
    private func postUpdateNotification() {
        NotificationCenter.default.post(name: .cartDidUpdate, object: nil)
    }
}
