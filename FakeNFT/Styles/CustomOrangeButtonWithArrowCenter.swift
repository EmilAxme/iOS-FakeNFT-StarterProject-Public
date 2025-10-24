//
//  CustomOrangeButtonWithArrow2.swift
//  FakeNFT
//
//  Created by Damir Salakhetdinov on 13/10/25.
//

import SwiftUI

struct CustomOrangeButtonWithArrowCenter: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            VStack {
                configuration.label // Center the button label vertically
            }
            .frame(maxWidth: .infinity) // Allow the label to stretch horizontally
            Spacer() // Push the icon to the far-right side
            Image(systemName: "chevron.right") // Right-facing arrow icon
                .foregroundStyle(.white) // Match foreground color
                .font(.system(size: 16)) // Optional font size adjustment
        }
        .frame(maxWidth:.infinity) // Horizontal expansion
        .padding() // Padding around the content
        .background(Color.orange) // Background color
        .foregroundStyle(.white) // Foreground colors match
        .clipShape(Capsule()) // Capsule shape for the button
        .opacity(configuration.isPressed ? 0.7 : 1.0) // Visual feedback on press
    }
}
