//
//  QuickNavigationView.swift
//  datanest
//
//  Created by Chidozie Okafor on 20/06/2024.
//

import SwiftUI

struct SidebarItem: View {
    let icon: String
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    @State private var isHovered = false
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.primaryText)
                Text(title)
                    .foregroundColor(.primaryText)
                Spacer()
            }
            .padding(.vertical, 8)
            .padding(.horizontal)
            .background(isSelected ? Color.button : (isHovered ? Color.secondaryText
                .opacity(0.1) : Color.clear))
            .cornerRadius(8)
            .padding(.horizontal, 10)
        }
        .buttonStyle(PlainButtonStyle())
        .onHover { hovering in
            withAnimation {
                isHovered = hovering
            }
        }
    }
}

struct QuickNavigationView: View {
    @Binding var selectedView: NavigationViewType
    
    var body: some View {
        ZStack{
            Color.primaryBackground
            VStack(alignment: .leading, spacing: 10) {
                SidebarItem(icon: "square.grid.2x2", title: "Dashboard", isSelected: selectedView ==  .dashboard) {
                    withAnimation {
                        selectedView = .dashboard
                    }
                }
                SidebarItem(icon: "externaldrive.badge.icloud", title: "Databases", isSelected: selectedView == .databases) {
                    withAnimation {
                        selectedView = .databases
                    }
                }
                SidebarItem(icon: "doc.text.magnifyingglass", title: "Logs", isSelected: selectedView == .logs) {
                    withAnimation {
                        selectedView = .logs
                    }
                }
                SidebarItem(icon: "hammer.fill", title: "Query Builder", isSelected: selectedView == .queryBuilder) {
                    withAnimation {
                        selectedView = .queryBuilder
                    }
                }
                SidebarItem(icon: "rectangle.3.offgrid.bubble.left", title: "Schema Designer", isSelected: selectedView == .schemaDesigner) {
                    withAnimation {
                        selectedView = .schemaDesigner                    }
                }
                SidebarItem(icon: "chart.bar.doc.horizontal", title: "Visualizations", isSelected: selectedView == .visualizations) {
                    withAnimation {
                        selectedView = .visualizations
                    }
                }
                SidebarItem(icon: "bell", title: "Notifications", isSelected: selectedView == .notifications) {
                    withAnimation {
                        selectedView = .notifications
                    }
                }
                SidebarItem(icon: "gear", title: "Settings", isSelected: selectedView == .settings) {
                    withAnimation {
                        selectedView = .settings
                    }
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    
                }
                .buttonStyle(PlainButtonStyle())
                .buttonBorderShape(.buttonBorder)
                .padding(.horizontal)
                
                Link(destination: URL(string: "https://github.com/doziestar/datanest")!) {
                    Text("Docs")
                        .font(.headline)
                        .foregroundColor(.secondaryText)
                        .background(Color.clear)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                

            }
            .padding(.vertical, 20)
        }
    }
}

#Preview {
    QuickNavigationView(selectedView: .constant(.dashboard))
}
