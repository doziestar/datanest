//
//  DBView.swift
//  datanest
//
//  Created by Chidozie Okafor on 23/06/2024.
//

import SwiftUI
import SwiftData


struct DBView: View {
    @State private var selectedDatabase: DatabaseType?
    @Environment(\.modelContext) private var modelContext
    @Query private var recentConnections: [DatabaseConnection]
    
    var body: some View {
        
        HStack {
            // Right side: Connection form or details
            if let selectedDB = selectedDatabase {
                ConnectionFormView(databaseType: selectedDB)
            } else {
                Text("Select a database type to connect")
            }
        }
        .background(Color.secondaryBackground)
    }
}


#Preview {
    DBView()
}
