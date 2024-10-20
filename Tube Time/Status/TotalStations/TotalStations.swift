//
//  TotalStations.swift
//  Tube Time
//
//  Created by Kamran Tailor on 12/10/2024.
//

import SwiftUI

struct TotalStations: View {
    let stations: [LineStation]
    let lineName: String
    
    // 1. Add a @State property to store the search query
    @State private var searchText: String = ""
    
    var filteredStations: [LineStation] {
        // 2. Filter the stations based on the search text
        if searchText.isEmpty {
            return stations
        } else {
            return stations.filter { station in
                station.commonName.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 20) { // Added spacing between elements
            
            // 3. Add a TextField for the search bar
            TextField("Search stations", text: $searchText)
                .padding(10)
                .background(Color(.systemGray5))
                .cornerRadius(10)
                .padding(.horizontal)
            
            ScrollView {
                NavigationStack {
                    VStack(spacing: 0) { // Stack for the cards
                        ForEach(filteredStations.indices, id: \.self) { index in
                            HStack(alignment: .center) {
                                // Pass station.id to StationCard
                                StationCard(station: filteredStations[index])
                                    .frame(maxWidth: .infinity) // Ensure each card takes full width
                            }
                        }
                    }
                    .padding(.horizontal) // Horizontal padding for the stations list
                }
            }
        }
        .navigationTitle(lineName)
        .navigationBarTitleDisplayMode(.inline)
    }
}
