//
//  CurrencyService.swift
//  FakeNFT
//
//  Created by Emil on 21.10.2025.
//

import Foundation

protocol CurrencyServiceProtocol {
    func loadCurrencies(completion: @escaping (Result<[CurrencyModel], Error>) -> Void)
}

final class CurrencyService: CurrencyServiceProtocol {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient = DefaultNetworkClient()) {
        self.networkClient = networkClient
    }

    func loadCurrencies(completion: @escaping (Result<[CurrencyModel], Error>) -> Void) {
        let request = CurrencyRequest()
        networkClient.send(request: request, type: [CurrencyModel].self, onResponse: completion)
    }
}
