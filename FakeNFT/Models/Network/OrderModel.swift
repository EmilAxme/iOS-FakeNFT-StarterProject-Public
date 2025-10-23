//
//  OrderModel.swift
//  FakeNFT
//
//  Created by Emil on 22.10.2025.
//

import Foundation

struct OrderModel: Decodable {
    let id: String
    let nfts: [String]
}
