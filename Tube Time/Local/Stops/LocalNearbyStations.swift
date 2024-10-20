//
//  LocalNearbyStations.swift
//  Tube Time
//
//  Created by Kamran Tailor on 14/10/2024.
//

import SwiftUI

struct LocalNearbyStations: View {
    let nearbyStations: [Station]
    
    var body: some View {
        Section(header: Text("Nearby Stations")
            .font(.headline)
            .foregroundColor(.primary) // Use system color for better contrast
            .padding(.bottom, 8)
        ) {
            
            if nearbyStations.isEmpty {
                
                //Code if there are no stations
                Text("No Stations Located")
                    .foregroundColor(.red)
                
            } else {
                
                //If there are stations present
                ForEach(nearbyStations, id: \.id) { station in
                    NavigationLink(destination: ViewStoppoint(id: station.id)) {
                        HStack {
                            Text(station.name)
                            
                            Spacer()
                            
                            if let distanceInMiles = convertToMiles(station.distance) {
                                Text(String(format: "%.2f Mi", distanceInMiles))
                                    .foregroundColor(.green)
                            }
                        }
                        .padding(.vertical, 6)
                    }
                }
            }
            
        }
        
    }
}
