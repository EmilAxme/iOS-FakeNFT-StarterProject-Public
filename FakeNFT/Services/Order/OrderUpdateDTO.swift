//
//  OrderUpdateDTO.swift
//  FakeNFT
//
//  Created by Emil on 23.10.2025.
//

import Foundation

struct OrderUpdateDto: Dto {
    let nfts: [String]
    
    func asDictionary() -> [String : String] {
        if nfts.isEmpty {
            return [:] // не передаём поле вообще
        } else {
            return ["nfts": nfts.joined(separator: ",")]
        }
    }
}
