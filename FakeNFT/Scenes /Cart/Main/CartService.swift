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
    var nfts: [NFTModel] { get }
    var delegate: CartServiceDelegate? { get set }
    
    func loadCartFromServer()
    func fetchNFTs() -> [NFTModel]
    func addNFT(_ nft: NFTModel)
    func removeNFT(_ nft: NFTModel)
    func clearCart()
}

extension Notification.Name {
    static let cartDidUpdate = Notification.Name("cartDidUpdate")
}

final class CartService: CartServiceProtocol {
    
    weak var delegate: CartServiceDelegate?
    
    static let shared = CartService() 
    
    private(set) var nfts: [NFTModel] = [] {
        didSet { delegate?.cartDidUpdate(self) }
    }
    
    private init() {}
    
    
    func fetchNFTs() -> [NFTModel] {
        return nfts
    }
    
    func removeNFT(_ nft: NFTModel) {
        nfts.removeAll { $0.id == nft.id }
        postUpdateNotification()
    }
    
    func addNFT(_ nft: NFTModel) {
        guard !nfts.contains(where: { $0.id == nft.id }) else { return }
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
