//
//  PaymentRequest.swift
//  FakeNFT
//
//  Created by Emil on 23.10.2025.
//

import Foundation

struct PaymentRequest: NetworkRequest {
    var dto: (any Dto)?
    
    let currencyId: String

    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1/payment/\(currencyId)")
    }

    var httpMethod: HttpMethod { .get }
}
