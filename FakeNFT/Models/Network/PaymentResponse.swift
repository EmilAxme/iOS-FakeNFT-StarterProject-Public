//
//  PaymentResponse.swift
//  FakeNFT
//
//  Created by Emil on 23.10.2025.
//

import Foundation

struct PaymentResponse: Decodable {
    let success: Bool
    let orderId: String
    let id: String
}
