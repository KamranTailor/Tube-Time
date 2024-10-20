//
//  LocalNearbyBusStops.swift
//  Tube Time
//
//  Created by Kamran Tailor on 14/10/2024.
//


import SwiftUI

struct LocalNearbyBusStops: View {
    let nearbyBusStops: [BusStop]
    @State private var displayedCount: Int = 5 // State variable to control how many stops are displayed

    var body: some View {
        Section(header: Text(nearbyBusStops.isEmpty ? "No Nearby Bus Stops" : "Nearby Bus Stops")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .padding(.bottom, 8)
        ) {
            if nearbyBusStops.isEmpty {
                Text("No Bus Stops Located")
                    .foregroundColor(.red)
                    .font(.subheadline)
                    .italic()
                    .padding(.vertical, 16)
            } else {
                ForEach(nearbyBusStops.prefix(displayedCount), id: \.id) { busStop in
                    NavigationLink(destination: ViewStoppoint(id: busStop.id)) {
                        VStack(alignment: .leading) {
                            HStack {
                                if let stopLetter = busStop.stopLetter?.uppercased() {
                                    switch stopLetter {
                                    case "->N":
                                        Text("[NOR]")
                                            .font(.subheadline)
                                            .foregroundColor(.blue)
                                    case "->S":
                                        Text("[SOU]")
                                            .font(.subheadline)
                                            .foregroundColor(.blue)
                                    case "->E":
                                        Text("[EST]")
                                            .font(.subheadline)
                                            .foregroundColor(.blue)
                                    case "->W":
                                        Text("[WST]")
                                            .font(.subheadline)
                                            .foregroundColor(.blue)
                                    default:
                                        // If the stopLetter isn't N, S, E, or W, display as is
                                        Text("[\(stopLetter)]")
                                            .font(.subheadline)
                                            .foregroundColor(.blue)
                                    }
                                } else {
                                    // If stopLetter is nil, show "[A]" as a default
                                    Text(busStop.stopLetter.map { "[\($0)] " } ?? "[A]")
                                        .font(.subheadline)
                                        .foregroundColor(.blue)
                                }

                                Text(busStop.commonName)
                                    .font(.body)
                                    .fontWeight(.semibold)
                            }
                            
                            let distanceInMiles = busStop.distance * 0.000621371
                            Text("\(String(format: "%.2f", distanceInMiles)) Mi")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                        .cornerRadius(8)
                        .padding(.vertical, 4)
                    }
                }
                
                // Show more button
                if displayedCount < nearbyBusStops.count {
                    Button(action: {
                        // Increase displayed count by 5, but not exceeding the total count
                        displayedCount = min(displayedCount + 5, nearbyBusStops.count)
                    }) {
                        HStack {
                            Text("Show More")
                                .padding()
                                .font(.headline)
                                .foregroundColor(.blue)
                                .frame(maxWidth: .infinity) // Take up all available space
                                .background(Color(UIColor.systemGray5))
                                .cornerRadius(8)
                        }
                    }
                    .layoutPriority(1) // Give priority to the Show More button
                }
                
                // Show less button
                if displayedCount > 5 {
                    Button(action: {
                        // Decrease displayed count by 5, but not going below 5
                        displayedCount = max(displayedCount - 5, 5)
                    }) {
                        HStack {
                            Text("Show Less")
                                .padding()
                                .font(.headline)
                                .foregroundColor(.blue)
                                .frame(maxWidth: .infinity) // Take up all available space
                                .background(Color(UIColor.systemGray5))
                                .cornerRadius(8)
                        }
                    }
                    .layoutPriority(1) // Give priority to the Show Less button
                }
            }
        }
    }
}

