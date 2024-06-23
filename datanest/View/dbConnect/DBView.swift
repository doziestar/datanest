//
//  DBView.swift
//  datanest
//
//  Created by Chidozie Okafor on 23/06/2024.
//

import SwiftUI
import SwiftData

// MARK: - Database Type Grid View
struct DatabaseTypeGridView: View {
    @Binding var selectedDatabaseType: DatabaseType?
    
    let columns = [GridItem(.adaptive(minimum: 100))]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(DatabaseType.allCases) { dbType in
                DatabaseTypeButton(type: dbType, selected: $selectedDatabaseType)
            }
        }
    }
}

// MARK: - Database Content View
struct DatabaseContentView: View {
    @Binding var selectedDatabaseType: DatabaseType?
    @Binding var selectedConnection: DatabaseConnection?
    @Environment(\.modelContext) private var modelContext
    @Query private var recentConnections: [DatabaseConnection]
    
    var body: some View {
        List {
            Section(header: Text("Database Types")) {
                DatabaseTypeGridView(selectedDatabaseType: $selectedDatabaseType)
            }
            
            Section(header: Text("Recent Connections")) {
                ForEach(recentConnections) { connection in
                    RecentConnectionRow(connection: connection)
                        .onTapGesture {
                            selectedConnection = connection
                            selectedDatabaseType = nil
                        }
                }
            }
        }
        .listStyle(SidebarListStyle())
        .navigationTitle("Databases")
    }
}

// MARK: - Main Database View
struct DatabaseView: View {
    @Binding var selectedView: NavigationViewType
    @State private var selectedDatabaseType: DatabaseType?
    @State private var selectedConnection: DatabaseConnection?
    
    var body: some View {
        NavigationSplitView {
            QuickNavigationView(selectedView: $selectedView)
        } content: {
            if selectedView == .databases {
                DatabaseContentView(
                    selectedDatabaseType: $selectedDatabaseType,
                    selectedConnection: $selectedConnection
                )
            } else {
                EmptyView()
            }
        } detail: {
            DatabaseDetailView(
                selectedDatabaseType: $selectedDatabaseType,
                selectedConnection: $selectedConnection
            )
        }
    }
}

// MARK: - Database Detail View
struct DatabaseDetailView: View {
    @Binding var selectedDatabaseType: DatabaseType?
    @Binding var selectedConnection: DatabaseConnection?
    
    var body: some View {
        ZStack {
            Color.secondaryBackground
            
            if let dbType = selectedDatabaseType {
                ConnectionFormView(databaseType: dbType)
            } else if let connection = selectedConnection {
                ConnectionDetailView(connection: connection)
            } else {
                Text("Select a database type to connect")
            }
        }
    }
}

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
