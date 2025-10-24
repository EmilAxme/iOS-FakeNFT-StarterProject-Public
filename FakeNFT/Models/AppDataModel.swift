//
//  AppDataModel.swift
//  FakeNFT
//
//  Created by Damir Salakhetdinov on 12/10/25.
//

import SwiftUI

//final class DataBaseStore {
//    static let shared = DataBaseStore()
//    
//    private init() {}
    
final class AppDataModel: ObservableObject {
    static let shared = AppDataModel()
    
    init() {

    }
    private(set) var nftUserProfile: NFTUserProfile = NFTUserProfile()
    
    func fetchProfile() {
        nftUserProfile = NFTUserProfile(
            username: "Joaquin Phoenix",
            description: "Photographer, NFT enthusiast",
            website: "www.google.com",
            avatarName: "avatar")
    }
}
