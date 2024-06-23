//
//  swiftDataSync.swift
//  datanest
//
//  Created by Chidozie Okafor on 20/06/2024.
//

import SwiftData

func syncData() -> ModelContainer {
    return {
        let schema = Schema([])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
}
