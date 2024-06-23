//
//  ConnectionFormView.swift
//  datanest
//
//  Created by Chidozie Okafor on 23/06/2024.
//

import SwiftUI

// MARK: - Connection Form View
struct ConnectionFormView: View {
    let databaseType: DatabaseType
    @State private var name = ""
    @State private var connectionString = ""
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        Form {
            Section(header: Text("Connection Details")) {
                TextField("Connection Name", text: $name)
                TextField("Connection String", text: $connectionString)
            }
            
            Section {
                Button("Connect") {
                    saveConnection()
                }
            }
        }
        .navigationTitle("Connect to \(databaseType.rawValue.capitalized)")
    }
    
    private func saveConnection() {
        let newConnection = DatabaseConnection(name: name, type: databaseType, connectionString: connectionString)
        modelContext.insert(newConnection)
        do {
            try modelContext.save()
        } catch {
            print("Error saving connection: \(error)")
        }
    }
}


#Preview {
    ConnectionFormView(databaseType: .mongo)
}
