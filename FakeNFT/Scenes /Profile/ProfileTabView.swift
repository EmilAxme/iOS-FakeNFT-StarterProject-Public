//
//  ProfileTabView.swift
//  FakeNFT
//
//  Created by Damir Salakhetdinov on 12/10/25.
//

import SwiftUI

struct ProfileTabView: View {
    var body: some View {
        TabView {
            ProfileView()
                .tabItem {
                    Label("Профиль", systemImage: "person.crop.circle")
                }

            Text("Каталог")
                .tabItem {
                    Label("Каталог", systemImage: "square.grid.2x2")
                }

            Text("Корзина")
                .tabItem {
                    Label("Корзина", systemImage: "cart")
                }

            Text("Статистика")
                .tabItem {
                    Label("Статистика", systemImage: "chart.bar")
                }
        }
    }
}

#Preview {
    ProfileTabView()
}
