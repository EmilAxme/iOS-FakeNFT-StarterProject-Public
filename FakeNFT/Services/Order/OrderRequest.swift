//
//  OrderRequest.swift
//  FakeNFT
//
//  Created by Emil on 22.10.2025.
//

import Foundation

struct OrderRequest: NetworkRequest {
    var dto: (any Dto)?
    
    var endpoint: URL? {
        URL(string:"\(RequestConstants.baseURL)/api/v1/orders/1")
    }
    
    var httpMethod: HttpMethod { .get }
}
