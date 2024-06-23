//
//  formatter.swift
//  datanest
//
//  Created by Chidozie Okafor on 23/06/2024.
//

import Foundation

let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
