//
//  Item.swift
//  datanest
//
//  Created by Chidozie Okafor on 19/06/2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
