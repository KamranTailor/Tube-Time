//
//  Local.swift
//  Tube Time
//
//  Created by Kamran Tailor on 17/02/2024.
//

import SwiftUI
import CoreLocation

struct Local: View {
    @EnvironmentObject var locationManager: LocationManager
    @Environment(\.colorScheme) var colorScheme
    
    // Define @State variables to hold the retrieved data
    @State private var nearbyStations: [Station] = []
    @State private var nearbyBusStops: [BusStop] = []
    @State private var isLoading = true
    
    let sampleArrivals = [
            ArrivalItem(title: "New Product A", date: Date().addingTimeInterval(3600)),
            ArrivalItem(title: "New Product B", date: Date().addingTimeInterval(7200)),
            ArrivalItem(title: "New Product C", date: Date().addingTimeInterval(10800))
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    Text("Loading...")
                        .padding()
                        .foregroundColor(.white)
                } else {
                    if nearbyStations.isEmpty && nearbyBusStops.isEmpty {
                        Text("This service is only available in Greater London.")
                            .padding()
                            .foregroundColor(.red)
                    } else {
                        List {
                            
                            LocalNearbyStations(nearbyStations: nearbyStations)
                            LocalNearbyBusStops(nearbyBusStops: nearbyBusStops)
                            
                        }
                    }
                }
            }
            .navigationTitle("Near you")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                sendLocationToAPI()
            }
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .accentColor(.blue)
        .background(colorScheme == .dark ? Color.black : Color.white)
    }
    
    func sendLocationToAPI() {
        if let latitude = locationManager.location?.coordinate.latitude,
           let longitude = locationManager.location?.coordinate.longitude {
            let urlString = "https://kamrantailor.com/app-tfl/nearby?lat=\(latitude)&lon=\(longitude)"
            
            if let url = URL(string: urlString) {
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                
                URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        print("Error: \(error.localizedDescription)")
                        return
                    }
                    
                    if let httpResponse = response as? HTTPURLResponse {
                        if httpResponse.statusCode == 200, let data = data {
                            do {
                                let decoder = JSONDecoder()
                                let nearbyResponse = try decoder.decode(NearbyResponse.self, from: data)
                                
                                DispatchQueue.main.async {
                                    nearbyStations = nearbyResponse.closestStations
                                    nearbyBusStops = nearbyResponse.busStops
                                    isLoading = false
                                }
                            } catch {
                                print("Error decoding JSON: \(error.localizedDescription)")
                            }
                        } else if httpResponse.statusCode == 500 {
                            DispatchQueue.main.async {
                                isLoading = false
                                nearbyStations = []
                                nearbyBusStops = []
                            }
                        } else {
                            print("HTTP Error: \(httpResponse.statusCode)")
                        }
                    }
                }.resume()
            }
        }
    }
}

func convertToMiles(_ distanceInKm: Double) -> Double? {
    let distanceInMiles = distanceInKm * 0.621371
    let roundedDistance = (distanceInMiles * 100).rounded() / 100
    return roundedDistance
}

#Preview {
    Local()
        .environmentObject(LocationManager())
}
