//
//  NFTUserProfile.swift
//  FakeNFT
//
//  Created by Damir Salakhetdinov on 12/10/25.
//

import Foundation

@Observable
class NFTUserProfile: Identifiable {
    init() {
        self.username = "Someone"
    }
    init(username: String, description: String, website: String, avatarName: String) {
        self.username = username
        self.description = description
        self.website = website
        self.avatarName = avatarName
    }
    let id = UUID()
    var username: String = ""
    var description: String = ""
    var website: String = ""
    var avatarName: String = ""
}
