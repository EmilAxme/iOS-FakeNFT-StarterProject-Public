//
//  OrderService.swift
//  FakeNFT
//
//  Created by Emil on 22.10.2025.
//

import Foundation

protocol OrderServiceProtocol {
    func loadOrder(completion: @escaping (Result<OrderModel, Error>) -> Void)
    func updateOrder(nftIDs: [String], completion: @escaping (Result<OrderModel, Error>) -> Void)
}

final class OrderService: OrderServiceProtocol {
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient = DefaultNetworkClient()) {
        self.networkClient = networkClient
    }
    
    func loadOrder(completion: @escaping (Result<OrderModel, Error>) -> Void) {
        let request = OrderRequest()
        networkClient.send(request: request, type: OrderModel.self, onResponse: completion)
    }
    
    func updateOrder(nftIDs: [String], completion: @escaping (Result<OrderModel, Error>) -> Void) {
        let dto = OrderUpdateDto(nfts: nftIDs)
        let request = OrderUpdateRequest(dto: dto)
        networkClient.send(request: request, type: OrderModel.self, onResponse: completion)
    }
}
