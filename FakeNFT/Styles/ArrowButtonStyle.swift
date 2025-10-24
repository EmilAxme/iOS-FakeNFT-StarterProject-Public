//
//  ArrowButtonStyle.swift
//  FakeNFT
//
//  Created by Damir Salakhetdinov on 13/10/25.
//

import SwiftUI

struct ArrowButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth:.infinity)
        HStack {
            Text("Next")
            Image(systemName: "chevron.right") // SF Symbol for a right arrow
        }
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(10)
    }
}
