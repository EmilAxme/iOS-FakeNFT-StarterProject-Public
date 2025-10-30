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
    
    func loadCartFromServer(completion: ((Result<[NFTModel], Error>) -> Void)?)
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
    
    private let orderService = OrderService()
    private let nftService = NftServiceImpl(networkClient: DefaultNetworkClient(), storage: NftStorageImpl())
    
    private init() {}
    
    func loadCartFromServer(completion: ((Result<[NFTModel], Error>) -> Void)? = nil) {
        orderService.loadOrder { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let order):
                self.nftService.loadNfts(ids: order.nfts) { nftsResult in
                    switch nftsResult {
                    case .success(let nfts):
                        let nftModels = nfts.map {
                            NFTModel(
                                id: $0.id,
                                name: $0.name,
                                price: $0.price,
                                rating: $0.rating,
                                imageURL: $0.images.first ?? ""
                            )
                        }
                        self.nfts = nftModels
                        completion?(.success(nftModels)) 
                    case .failure(let error):
                        print("❌ Ошибка загрузки NFT: \(error)")
                        completion?(.failure(error))
                    }
                }
            case .failure(let error):
                print("❌ Ошибка загрузки заказа: \(error)")
                completion?(.failure(error))
            }
        }
    }
    
    func fetchNFTs() -> [NFTModel] {
        return nfts
    }
    
    func addNFT(_ nft: NFTModel) {
        guard !nfts.contains(where: { $0.id == nft.id }) else { return }
        nfts.append(nft)
        postUpdateNotification()
    }
    
    func removeNFT(_ nft: NFTModel) {
        let updatedNFTs = nfts.filter { $0.name != nft.name }
        let nftIDs = updatedNFTs.map { $0.id }

        syncOrderWithServer(nftIDs: nftIDs) { [weak self] success in
            guard let self else { return }
            if success {
                self.nfts = updatedNFTs
                self.postUpdateNotification()
            } else {
                print("❌ Не удалось удалить NFT — сервер не подтвердил изменение")
            }
        }
    }

    func clearCart() {
        syncOrderWithServer(nftIDs: []) { [weak self] success in
            guard let self else { return }
            if success {
                self.nfts.removeAll()
                self.postUpdateNotification()
            } else {
                print("❌ Не удалось очистить корзину — сервер не подтвердил изменение")
            }
        }
    }

    private func syncOrderWithServer(nftIDs: [String], completion: @escaping (Bool) -> Void) {
        orderService.updateOrder(nftIDs: nftIDs) { result in
            switch result {
            case .success(let order):
                print("✅ Заказ обновлён на сервере: \(order)")
                completion(true)
            case .failure(let error):
                print("❌ Ошибка обновления заказа: \(error)")
                completion(false)
            }
        }
    }
    
    private func postUpdateNotification() {
        NotificationCenter.default.post(name: .cartDidUpdate, object: nil)
    }
}
