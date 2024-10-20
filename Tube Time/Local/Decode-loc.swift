//
//  Decode.swift
//  Tube Time
//
//  Created by Kamran Tailor on 18/02/2024.
//

import Foundation

struct NearbyResponse: Codable {
    let nearLondon: Bool
    let closestStations: [Station]
    let busStops: [BusStop]
}

struct Station: Codable {
    let name: String
    let id: String
    let lat: Double
    let lon: Double
    let distance: Double
}

struct BusStop: Codable {
    let naptanId: String
    let stopLetter: String?
    let stopType: String
    let id: String
    let commonName: String
    let distance: Double
    let lat: Double
    let lon: Double
}
