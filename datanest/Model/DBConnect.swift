//
//  DBConnect.swift
//  datanest
//
//  Created by Chidozie Okafor on 23/06/2024.
//

import SwiftUI
import SwiftData

enum DatabaseType: String, CaseIterable, Identifiable {
    case mongo, postgres, redis, cassandra, mysql, sqlite
    var id: String { self.rawValue }
}

@Model
class DatabaseConnection {
    var id: UUID?
    var name: String
    var connectionString: String
    var lastConnected: Date
    var typeRawValue: String = ""
    
    var type: DatabaseType {
            get { DatabaseType(rawValue: typeRawValue)! }
            set { typeRawValue = newValue.rawValue }
        }
    
    init(name: String, type: DatabaseType, connectionString: String) {
            self.id = UUID()
            self.name = name
            self.typeRawValue = type.rawValue
            self.connectionString = connectionString
            self.lastConnected = Date()
        }
}
