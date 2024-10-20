//
//  StatusDecode.swift
//  Tube Time
//
//  Created by Kamran Tailor on 06/10/2024.
//


import SwiftUI

// Model for Line Status
struct LineStatus: Codable {
    let statusSeverity: Int
    let statusSeverityDescription: String?
    let reason: String?
}

// Model for Line
struct Line: Codable {
    let id: String
    let name: String
    let lineStatuses: [LineStatus]
}

// Model for Transport Data
struct TransportData: Codable {
    let tubeData: [Line]
    let elizabethData: [Line]
    let dlrData: [Line]
    let tramData: [Line]
    let overgroundData: [Line]
}
