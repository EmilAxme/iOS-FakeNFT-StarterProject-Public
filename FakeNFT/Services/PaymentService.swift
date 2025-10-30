//
//  PaymentService.swift
//  FakeNFT
//
//  Created by Emil on 23.10.2025.
//

import Foundation

protocol PaymentServiceProtocol {
    func pay(with currencyId: String, completion: @escaping (Result<PaymentResponse, Error>) -> Void)
}

final class PaymentService: PaymentServiceProtocol {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient = DefaultNetworkClient()) {
        self.networkClient = networkClient
    }

    func pay(with currencyId: String, completion: @escaping (Result<PaymentResponse, Error>) -> Void) {
        let request = PaymentRequest(currencyId: currencyId)
        networkClient.send(request: request, type: PaymentResponse.self, onResponse: completion)
    }
}
