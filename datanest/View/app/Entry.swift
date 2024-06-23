//
//  Entry.swift
//  datanest
//
//  Created by Chidozie Okafor on 20/06/2024.
//

import SwiftUI
import SwiftData

// MARK: - Main Entry Point
struct Entry: View {
    @State private var selectedView: CustomNavigationViewType = .dashboard
    @State private var isShowingNewItemSheet = false
    @State private var selectedDatabaseType: DatabaseType?
    @State private var selectedConnection: DatabaseConnection?
    
    var body: some View {
        NavigationSplitView {
            Sidebar(selectedView: $selectedView)
        } content: {
            ContentView(
                selectedView: $selectedView,
                selectedDatabaseType: $selectedDatabaseType,
                selectedConnection: $selectedConnection
            )
        } detail: {
            DetailView(
                selectedView: $selectedView,
                selectedDatabaseType: $selectedDatabaseType,
                selectedConnection: $selectedConnection
            )
        }
        .navigationTitle(navigationTitle)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button(action: { isShowingNewItemSheet = true }) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isShowingNewItemSheet) {
            NewItemView(selectedView: $selectedView)
        }
    }
    
    private var navigationTitle: String {
        switch selectedView {
        case .dashboard: return "Dashboard"
        case .databases: return "Databases"
        case .logs: return "Logs"
        case .queryBuilder: return "Query Builder"
        case .schemaDesigner: return "Schema Designer"
        case .visualizations: return "Visualizations"
        case .notifications: return "Notifications"
        case .settings: return "Settings"
        }
    }
}

// MARK: - Sidebar
struct Sidebar: View {
    @Binding var selectedView: CustomNavigationViewType
    
    var body: some View {
        List(CustomNavigationViewType.allCases, selection: $selectedView) { viewType in
            NavigationLink(value: viewType) {
                Label(viewType.title, systemImage: viewType.iconName)
            }
        }
        .listStyle(SidebarListStyle())
    }
}

// MARK: - Content View
struct ContentView: View {
    @Binding var selectedView: CustomNavigationViewType
    @Binding var selectedDatabaseType: DatabaseType?
    @Binding var selectedConnection: DatabaseConnection?
    
    var body: some View {
        switch selectedView {
        case .databases:
            DatabaseContentView(
                selectedDatabaseType: $selectedDatabaseType,
                selectedConnection: $selectedConnection
            )
        default:
            Text("Select an item")
        }
    }
}

// MARK: - Detail View
struct DetailView: View {
    @Binding var selectedView: CustomNavigationViewType
    @Binding var selectedDatabaseType: DatabaseType?
    @Binding var selectedConnection: DatabaseConnection?
    
    var body: some View {
        switch selectedView {
        case .dashboard:
            DashboardView()
        case .databases:
            DatabaseDetailView(
                selectedDatabaseType: $selectedDatabaseType,
                selectedConnection: $selectedConnection
            )
        case .logs:
            LogsView()
        case .queryBuilder:
            QueryBuilderView()
        case .schemaDesigner:
            SchemaDesignerView()
        case .visualizations:
            VisualizationsView()
        case .notifications:
            NotificationsView()
        case .settings:
            SettingsView()
        }
    }
}

// MARK: - New Item View
struct NewItemView: View {
    @Binding var selectedView: CustomNavigationViewType
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            Form {
            }
            .navigationTitle("New \(selectedView.title)")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        dismiss()
                    }
                }
            }
        }
    }
}

// MARK: - Navigation View Type
enum CustomNavigationViewType: String, CaseIterable, Identifiable {
    case dashboard, databases, logs, queryBuilder, schemaDesigner, visualizations, notifications, settings
    
    var id: String { self.rawValue }
    
    var title: String {
        switch self {
        case .dashboard: return "Dashboard"
        case .databases: return "Databases"
        case .logs: return "Logs"
        case .queryBuilder: return "Query Builder"
        case .schemaDesigner: return "Schema Designer"
        case .visualizations: return "Visualizations"
        case .notifications: return "Notifications"
        case .settings: return "Settings"
        }
    }
    
    var iconName: String {
        switch self {
        case .dashboard: return "square.grid.2x2"
        case .databases: return "externaldrive.badge.icloud"
        case .logs: return "doc.text.magnifyingglass"
        case .queryBuilder: return "hammer.fill"
        case .schemaDesigner: return "rectangle.3.offgrid.bubble.left"
        case .visualizations: return "chart.bar.doc.horizontal"
        case .notifications: return "bell"
        case .settings: return "gear"
        }
    }
}

// MARK: - Placeholder Views
struct DashboardView: View {
    var body: some View {
        Text("Dashboard Content")
    }
}

struct LogsView: View {
    var body: some View {
        Text("Logs Content")
    }
}

struct QueryBuilderView: View {
    var body: some View {
        Text("Query Builder Content")
    }
}

struct SchemaDesignerView: View {
    var body: some View {
        Text("Schema Designer Content")
    }
}

struct VisualizationsView: View {
    var body: some View {
        Text("Visualizations Content")
    }
}

struct NotificationsView: View {
    var body: some View {
        Text("Notifications Content")
    }
}

struct SettingsView: View {
    var body: some View {
        Text("Settings Content")
    }
}

// MARK: - Preview
#Preview {
    Entry()
}
