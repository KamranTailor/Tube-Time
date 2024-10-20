//
//  Stoppoint-Decode.swift
//  Tube Time
//
//  Created by Kamran Tailor on 18/02/2024.
//

import Foundation

struct StopPoint: Codable {
    let stationData: StationDataStop
    let arrivals: [Arrivals]
}

struct StationDataStop: Codable {
    let commonName: String
    let lat: Double
    let lon: Double
    let lines: [LineStop]
    let id: String
}

struct LineStop: Codable {
    let id: String
    let name: String
}

struct Arrivals: Codable {
    let lineName: String
    let platformName: String
    let destinationName: String? // Make it optional by adding '?'
    let expectedArrival: String
    let id: String
}
