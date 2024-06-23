//
//  DatabaseView.swift
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
        ZStack{
            Color.secondaryBackground
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(DatabaseType.allCases) { dbType in
                    DatabaseTypeButton(type: dbType, selected: $selectedDatabaseType)
                }
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
        ZStack{
            Color.secondaryBackground
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
}


// MARK: - Main Database View
struct DatabaseView: View {
    @Binding var selectedView: NavigationViewType
    @State private var selectedDatabaseType: DatabaseType?
    @State private var selectedConnection: DatabaseConnection?
    
    var body: some View {
        ZStack {
            Color.secondaryBackground
            NavigationSplitView {
                QuickNavigationView(selectedView: $selectedView)
            } content: {
                ZStack {
                    Color.secondaryBackground
                    if selectedView == .databases {
                        DatabaseContentView(
                            selectedDatabaseType: $selectedDatabaseType,
                            selectedConnection: $selectedConnection
                        )
                    } else {
                        EmptyView()
                    }
                }
            } detail: {
                DatabaseDetailView(
                    selectedDatabaseType: $selectedDatabaseType,
                    selectedConnection: $selectedConnection
                )
            }
        }
    }
}

#Preview {
    DatabaseView(selectedView: .constant(.databases))
}
