//
//  FakeNFTApp.swift
//  FakeNFT
//
//  Created by Damir Salakhetdinov on 12/10/25.
//

import SwiftUI

//@main
//struct FakeNFTApp: App {
//    let persistenceController = PersistenceController.shared
//
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//        }
//    }
//}

@main
struct FakeNFTApp: App {
    @StateObject private var servicesAssembly = ServicesAssembly(
        networkClient: DefaultNetworkClient(),
        nftStorage: NftStorageImpl()
    )

    var body: some Scene {
        WindowGroup {
            ProfileTabView()
                .environmentObject(servicesAssembly)
        }
    }
}






