//
//  CustomButtonWithArrow.swift
//  FakeNFT
//
//  Created by Damir Salakhetdinov on 13/10/25.
//
import SwiftUI

struct CustomButtonWithArrow: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label // Original button label/text
            Spacer()
            Image(systemName: "chevron.forward") // Right-facing arrow icon
                .foregroundStyle(.black) // Match foreground color
                .font(.system(size: 16, weight: .bold)) // Optional font size adjustment
        }
        .frame(maxWidth:.infinity) // Horizontal expansion
        .padding() // Padding around the content
        .background(Color.white) // Background color
        .foregroundStyle(.black) // Foreground colors match
        .clipShape(Capsule()) // Capsule shape for the button
        .opacity(configuration.isPressed ? 0.7 : 1.0) // Visual feedback on press
        .font(.system(size: 16, weight: .bold))
    }
}
