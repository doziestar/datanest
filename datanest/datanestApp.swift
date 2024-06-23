//
//  datanestApp.swift
//  datanest
//
//  Created by Chidozie Okafor on 19/06/2024.
//

import SwiftUI
import SwiftData

@main
struct datanestApp: App {
    var sharedModelContainer: ModelContainer = syncData()
    var body: some Scene {
        WindowGroup {
            Entry()
        }
        .modelContainer(sharedModelContainer)
    }
}
