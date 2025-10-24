//
//  ProfileView.swift
//  FakeNFT
//
//  Created by Damir Salakhetdinov on 12/10/25.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject
    private var appDataModel = AppDataModel.shared
    
    init() {
        appDataModel.fetchProfile()
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                VStack(alignment: .leading, spacing: 8) {
                    // MARK: - Верхняя строка: аватар и имя
                    HStack(alignment: .center, spacing: 20) {
                        Image(appDataModel.nftUserProfile.avatarName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            //.shadow(radius: 6)

                        Text(appDataModel.nftUserProfile.username)
                            .font(.title2)
                            .fontWeight(.semibold)

                        Spacer()
                    }

                    // MARK: - Нижняя строка: описание и ссылка
                    VStack(alignment: .leading, spacing: 4) {
                        Text(appDataModel.nftUserProfile.description)
                            .font(.subheadline)
                            //.foregroundColor(.gray)

                        Text(appDataModel.nftUserProfile.website)
                            .font(.subheadline)
                            .foregroundColor(.blue)
                            //.underline()
                    }
                }
                .padding(.top, 40)
                .padding(.horizontal, 16)


                // MARK: - Кнопки перехода
                VStack(spacing: 0) {
                    Button(action: {}) {
                        Text("my_nfts")
                    }
                    .buttonStyle(CustomButtonWithArrow())

                    Button(action: {}) {
                        Text("favorites_nfts")
                    }
                    .buttonStyle(CustomButtonWithArrow())
                }
                .padding(.horizontal, 20)

                Spacer()
            }
            //.navigationTitle("Профиль")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                            // TODO: переход к редактированию профиля
                        }) {
                            Image(systemName: "square.and.pencil")
                                .font(.system(size: 18, weight: .bold)) // делаем иконку жирной и чуть крупнее
                                            .foregroundColor(.black) // цвет иконки — чёрный
                        }
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}

