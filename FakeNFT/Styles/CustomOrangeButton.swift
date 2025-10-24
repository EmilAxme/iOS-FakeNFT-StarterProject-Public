//
//  SolidButton.swift
//  FakeNFT
//
//  Created by Damir Salakhetdinov on 13/10/25.
//

import SwiftUI

struct CustomOrangeButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth:.infinity)
            .padding()
            .background(Color.orange)
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .opacity(configuration.isPressed ? 0.7 : 1.0) // Add a visual feedback for pressing
    }
}


