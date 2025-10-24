//
//  ProfileHeaderView.swift
//  FakeNFT
//
//  Created by Damir Salakhetdinov on 12/10/25.
//

import SwiftUI

struct ProfileHeaderView: View {
    let profile: NFTUserProfile

    var body: some View {
        VStack(spacing: 12) {
            Image(profile.avatarName)
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 120)
                .clipShape(Circle())
                .shadow(radius: 6)
            
            Text(profile.username)
                .font(.title)
                .bold()
            
            Text(profile.description)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Link(destination: URL(string: profile.website)!) {
                Text(profile.website)
                    .font(.footnote)
                    .foregroundColor(.blue)
                    .underline()
            }
        }
        .padding(.top)
    }
}
