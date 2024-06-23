//
//  DatabaseTypeButton.swift
//  datanest
//
//  Created by Chidozie Okafor on 23/06/2024.
//

import SwiftUI

// MARK: - Database Type Button
struct DatabaseTypeButton: View {
    let type: DatabaseType
    @Binding var selected: DatabaseType?
    
    var body: some View {
        Button(action: {
            selected = type
        }) {
            VStack {
                Image(systemName: iconForDatabase(type))
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                Text(type.rawValue.capitalized)
                    .font(.caption)
                    .foregroundColor(.white)
            }
            .frame(width: 100, height: 100)
            .background(Color.blue.opacity(0.8))
            .cornerRadius(10)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    func iconForDatabase(_ type: DatabaseType) -> String {
        switch type {
        case .mongo: return "circle.grid.cross"
        case .postgres: return "elephant"
        case .redis: return "cube"
        case .cassandra: return "circle.grid.3x3"
        case .mysql: return "server.rack"
        case .sqlite: return "externaldrive"
        }
    }
}

#Preview {
    DatabaseTypeButton(type: .mongo, selected: .constant(.mongo))
}
