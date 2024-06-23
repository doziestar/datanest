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
}

// MARK: - Database Detail View
struct DatabaseDetailView: View {
    @Binding var selectedDatabaseType: DatabaseType?
    @Binding var selectedConnection: DatabaseConnection?
    @State private var connectionName = ""
    @State private var connectionString = ""
    @State private var hostname = ""
    @State private var isEditingConnectionString = false
    @State private var selectedTab: ConnectionTab = .general
    @State private var isFavorite = false
    
    private let tabs: [ConnectionTab] = [.general, .authentication, .tlsSSL, .proxySSH, .inUseEncryption, .advanced]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header
                HStack {
                    Text("New Connection")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                    Button(action: { isFavorite.toggle() }) {
                        Image(systemName: isFavorite ? "star.fill" : "star")
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                if let dbType = selectedDatabaseType {
                    Text("Connect to a \(dbType.rawValue.capitalized) deployment")
                        .foregroundColor(.secondary)
                }
                
                // Connection String
                VStack(alignment: .leading) {
                    HStack {
                        Text("URI")
                        Image(systemName: "info.circle")
                    }
                    TextEditor(text: $connectionString)
                        .frame(height: 100)
                        .padding(8)
                        .background(Color.secondary.opacity(0.2))
                        .cornerRadius(8)
                }
                
                // Edit Connection String Toggle
                Toggle("Edit Connection String", isOn: $isEditingConnectionString)
                    .padding(.vertical)
                
                // Tabs
                Picker("Options", selection: $selectedTab) {
                    ForEach(tabs, id: \.self) { tab in
                        Text(tab.title).tag(tab)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                // Tab Content
                tabContent
                
                // Buttons
                HStack {
                    Button("Save") {
                        // Implement save logic
                    }
                    .buttonStyle(BorderedButtonStyle())
                    
                    Spacer()
                    
                    Button("Save & Connect") {
                        // Implement save and connect logic
                    }
                    .buttonStyle(BorderedProminentButtonStyle())
                    
                    Button("Connect") {
                        // Implement connect logic
                    }
                    .buttonStyle(BorderedProminentButtonStyle())
                }
            }
            .padding()
        }
        .background(Color(.secondaryBackground))
    }
    
    @ViewBuilder
    private var tabContent: some View {
        switch selectedTab {
        case .general:
            generalTabContent
        case .authentication:
            Text("Authentication options")
        case .tlsSSL:
            Text("TLS/SSL options")
        case .proxySSH:
            Text("Proxy/SSH options")
        case .inUseEncryption:
            Text("In-Use Encryption options")
        case .advanced:
            Text("Advanced options")
        }
    }
    
    private var generalTabContent: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Connection String Scheme")
            HStack {
                Button("mongodb") {
                    // Update connection string scheme
                }
                .buttonStyle(BorderedButtonStyle())
                
                Button("mongodb+srv") {
                    // Update connection string scheme
                }
                .buttonStyle(BorderedProminentButtonStyle())
            }
            
            Text("DNS Seed List Connection Format. The +srv indicates to the client that the hostname that follows corresponds to a DNS SRV record.")
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text("Hostname")
            TextField("Enter hostname", text: $hostname)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

enum ConnectionTab: String, CaseIterable {
    case general, authentication, tlsSSL, proxySSH, inUseEncryption, advanced
    
    var title: String {
        switch self {
        case .general: return "General"
        case .authentication: return "Authentication"
        case .tlsSSL: return "TLS/SSL"
        case .proxySSH: return "Proxy/SSH"
        case .inUseEncryption: return "In-Use Encryption"
        case .advanced: return "Advanced"
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
