//
//  DatabaseConnectionView.swift
//  datanest
//
//  Created by Chidozie Okafor on 23/06/2024.
//

import SwiftUI

struct DatabaseConnectionView: View {
    @State private var selectedDatabase: DatabaseType?
    @State private var showConnectionForm = false
    
    var body: some View {
        NavigationView {
            VStack {
                // Grid of database options
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach(DatabaseType.allCases) { dbType in
                        DatabaseTypeButton(type: dbType, selected: $selectedDatabase)
                    }
                }
                .padding()
                
                // Recently connected databases
                RecentConnectionsView()
                
                Spacer()
            }
            .navigationTitle("New Connection")
            .sheet(isPresented: $showConnectionForm) {
                if let database = selectedDatabase {
                    ConnectionFormView(databaseType: database)
                }
            }
        }
    }
}


#Preview {
    DatabaseConnectionView()
}
