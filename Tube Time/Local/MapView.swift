//
//  MapView.swift
//  Tube Time
//
//  Created by Kamran Tailor on 24/02/2024.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    @State private var route: MKRoute?
    @State private var travelTime: String?
    private let gradient = LinearGradient(colors: [.red, .orange], startPoint: .leading, endPoint: .trailing)
    private let stroke = StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round, dash: [8, 8])

    
    let lat: Double
    let lon: Double
    let name: String
    
    @State var cammera: MapCameraPosition = .automatic
    
    var body: some View {
        Map(position: $cammera) {
            Marker(name,
                   systemImage: "tram",
                   coordinate: CLLocationCoordinate2D(
                    latitude: lat,
                    longitude:lon)
            ) .tint(.blue)
        }
        .mapControls{
            MapUserLocationButton()
            MapCompass()
            MapScaleView()
            MapPitchToggle()
        }
        
    }
}


#Preview {
    MapView(lat: 51.11, lon: 51.11, name: "Kings Cross")
}
