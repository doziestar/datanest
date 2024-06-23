//
//  DatabaseDetailView.swift
//  datanest
//
//  Created by Chidozie Okafor on 23/06/2024.
//

import SwiftUI

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
            ZStack{
                Color.tertiayBackground
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
                            HStack{
                                Text("URI")
                                Image(systemName: "info.circle")
                                Spacer()
                                // Edit Connection String Toggle
                                Toggle("Edit Connection", isOn: $isEditingConnectionString)
                                    .padding(.vertical)
                                
                            }
                        }
                        TextEditor(text: $connectionString)
                            .frame(height: 100)
                            .padding(8)
                            .background(Color.secondary.opacity(0.2))
                            .cornerRadius(8)
                    }
                    
                   
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
                .padding(.all, 20)
                .border(Color(.border))
            }
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


#Preview {
    DatabaseDetailView(selectedDatabaseType: .constant(
        .mongo), selectedConnection: .constant(nil))
}
