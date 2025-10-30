//
//  CurrencyRequest.swift
//  FakeNFT
//
//  Created by Emil on 21.10.2025.
//

import Foundation

struct CurrencyRequest: NetworkRequest {
    var dto: (any Dto)?
    
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/currencies")
    }
    var httpMethod: HttpMethod { .get }
}
