//
//  RecentConnectionsView.swift
//  datanest
//
//  Created by Chidozie Okafor on 23/06/2024.
//

import SwiftUI
import SwiftData

struct RecentConnectionsView: View {
    @Query private var recentConnections: [DatabaseConnection]
    
    var body: some View {
        List(recentConnections) { connection in
            NavigationLink(destination: ConnectionDetailView(connection: connection)) {
                Text(connection.name)
            }
        }
    }
}

struct RecentConnectionRow: View {
    let connection: DatabaseConnection
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(connection.name)
                .font(.headline)
            Text(connection.type.rawValue.capitalized)
                .font(.subheadline)
            Text("Last connected: \(connection.lastConnected, formatter: itemFormatter)")
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    RecentConnectionsView()
}
