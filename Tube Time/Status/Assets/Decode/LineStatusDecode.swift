//
//  LineStatusDecode.swift
//  Tube Time
//
//  Created by Kamran Tailor on 08/10/2024.
//

import Foundation

// Represents the main data structure for a Tube Line
struct LineData: Codable {
    let lineStatus: LineStatusFullLine // A single LineStatus object
    let name: String // The name of the tube line
    let crowding: Crowding? // Optional crowding information
    let amoutOfStations: Int // The total number of stations
    let stations: [LineStation] // Array of stations
}

// Represents the status of the tube line, which contains multiple statuses
struct LineStatusFullLine: Codable {
    let lineStatuses: [LineStatusDetail] // Array of detailed status objects
}

// Represents an individual station on the tube line
struct LineStation: Codable, Identifiable {
    let id: String  // Using naptanId as the unique identifier
    let naptanId: String // The unique station identifier
    let commonName: String // The station's name
    let lines: [LineDetail] // List of lines serving this station
}

// Represents the details for each line at a station
struct LineDetail: Codable {
    let id: String // Line ID (can be numerical or string-based)
    let name: String // Name of the line
}

// Represents crowding data (can be expanded as needed)
struct Crowding: Codable {
    // Add any crowding-specific details here if available
    let level: Int? // Optional crowding level (if applicable)
}

// Represents the detailed status of the tube line
struct LineStatusDetail: Codable {
    let statusSeverity: Int // The severity of the status
    let statusSeverityDescription: String? // Optional description of the status
    let reason: String? // Optional reason for the status
}
