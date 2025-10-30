//
//  OrderUpdateRequest.swift
//  FakeNFT
//
//  Created by Emil on 23.10.2025.
//

import Foundation

struct OrderUpdateRequest: NetworkRequest {
    var dto: Dto?
    
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1")
    }
    
    var httpMethod: HttpMethod { .put }
}
