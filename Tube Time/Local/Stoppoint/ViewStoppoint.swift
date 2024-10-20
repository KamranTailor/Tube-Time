//
//  ViewStoppoint.swift
//  Tube Time
//
//  Created by Kamran Tailor on 18/02/2024.
//

import SwiftUI
import MapKit
import CoreLocationUI

struct ViewStoppoint: View {
    let id: String
    @State private var stopPoint: StopPoint?
    @State private var lastRefreshed: Date?

    @State private var showAllArrivals = false
        
    var displayedArrivals: [Arrivals] {
        if let stopPoint = stopPoint {
            if showAllArrivals {
                return stopPoint.arrivals
            } else {
                return Array(stopPoint.arrivals.prefix(3))
            }
        } else {
            return []
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                if let stopPoint = stopPoint {
                    
                    // Arrivals Section
                    Section(header: Text("Arrivals")) {
                        ForEach(displayedArrivals.sorted { $0.expectedArrival < $1.expectedArrival }, id: \.id) { arrival in
                            VStack(alignment: .leading, spacing: 8) {
                                Text("\(arrival.lineName)")
                                    .font(.headline)
                                Text("Platform: \(arrival.platformName)")
                                    .font(.subheadline)
                                if let destinationName = arrival.destinationName {
                                    Text("To \(destinationName)")
                                        .font(.subheadline)
                                        .foregroundColor(.blue)
                                } else {
                                    Text("Unknown Destination")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                if let formattedTime = formattedTime(from: arrival.expectedArrival) {
                                    Text("Expected Arrival: \(formattedTime)")
                                        .font(.subheadline)
                                        .foregroundColor(.green)
                                } else {
                                    Text("Expected Arrival: N/A")
                                        .font(.subheadline)
                                        .foregroundColor(.red)
                                }
                            }.padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)) // Add padding around the VStack
                        }
                        
                        if !showAllArrivals && stopPoint.arrivals.count > 3 {
                            Button(action: {
                                showAllArrivals.toggle()
                            }) {
                                Text("Show All Arrivals")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    
                    // Station Information Section
                    Section(header: Text("Station Information")) {
                        NavigationLink(destination:  MapView(
                            lat: stopPoint.stationData.lat,
                            lon: stopPoint.stationData.lon,
                            name: stopPoint.stationData.commonName
                        ).navigationBarHidden(true)
                        ) {
                            Text("View On Map")
                        }
                        Text("Latitude: \(stopPoint.stationData.lat)")
                        Text("Longitude: \(stopPoint.stationData.lon)")
                        Text("ID: \(stopPoint.stationData.id)")
                    }
                    
                    // Lines Section
                    Section(header: Text("Lines")) {
                        ForEach(stopPoint.stationData.lines, id: \.id) { line in
                            Text("\(line.name)")
                        }
                    }
                } else {
                    Text("Loading...")
                        .onAppear {
                            fetchStopPoint()
                        }
                }
            }
            .navigationBarTitle(stopPoint?.stationData.commonName ?? "Station Detail")
            .navigationBarItems(trailing: HStack {
                if let lastRefreshed = lastRefreshed {
                    Text("Last Refreshed: \(lastRefreshed, formatter: dateFormatter)")
                        .foregroundColor(.gray)
                        .font(.caption)
                    Button(action: {
                        fetchData()
                    }) {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            })
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    func fetchStopPoint() {
        let urlString = "https://kamrantailor.com/app-tfl/tfl-stoppoint?id=\(id)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                print("Invalid response")
                return
            }
            
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(StopPoint.self, from: data)
                    DispatchQueue.main.async {
                        self.stopPoint = decodedData
                        self.lastRefreshed = Date()
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
    
    func formattedTime(from timestamp: String) -> String? {
        // Define a DateFormatter
        let dateFormatter = DateFormatter()
        // Set the date format according to your timestamp
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        // Convert the timestamp string into a Date object
        if let timestampDate = dateFormatter.date(from: timestamp) {
            // Set the date format for displaying time
            dateFormatter.dateFormat = "h:mm a"
            // Format the date to display the time
            let formattedTime = dateFormatter.string(from: timestampDate)
            return formattedTime
        } else {
            // Handle invalid timestamp format
            return nil
        }
    }
    
    // DateFormatter for displaying the last refreshed timestamp
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .medium
        return formatter
    }()

    // Function to manually trigger data fetching
    func fetchData() {
        fetchStopPoint()
    }
}

#Preview {
    ViewStoppoint(id: "910GCHRX")
}
