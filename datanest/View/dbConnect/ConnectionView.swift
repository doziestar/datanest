//
//  ConnectionView.swift
//  datanest
//
//  Created by Chidozie Okafor on 23/06/2024.
//

import SwiftUI

struct ConnectionDetailView: View {
    @Bindable var connection: DatabaseConnection
    
    var body: some View {
        Form {
            Section(header: Text("Connection Details")) {
                TextField("Name", text: $connection.name)
                TextField("Connection String", text: $connection.connectionString)
                Text("Type: \(connection.type.rawValue.capitalized)")
                Text("Last Connected: \(connection.lastConnected, formatter: itemFormatter)")
            }
            
            Section {
                Button("Update Connection") {
                    // Implement update logic
                }
                Button("Connect") {
                    // Implement connection logic
                }
            }
        }
        .navigationTitle(connection.name)
    }
}

#Preview {
    ConnectionDetailView(connection: DatabaseConnection(name: "", type: .mongo, connectionString: ""))
}
