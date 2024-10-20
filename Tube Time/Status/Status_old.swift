//
//  Status.swift
//  Tube Time
//
//  Created by Kamran Tailor on 17/02/2024.
//

import SwiftUI

struct Status_old: View {
    @State private var tubeData: TubeData?
    @State private var lastUpdated: Date?

    var body: some View {
        NavigationView {
            if let tubeData = tubeData {
                List {
                    Section("Underground") {
                        ForEach(tubeData.tubeData, id: \.id) { line in
                            if let statusDescription = line.lineStatuses.first?.statusSeverityDescription {
                                NavigationLink(destination: LinesInfo(lineName: line.name, lineData: line)) {
                                    TFLButton(title: line.name,
                                              tintColor: lineTintColor(for: line.name),
                                              type: "underground",
                                              status: statusDescription)
                                }
                            } else {
                                NavigationLink(destination: LinesInfo(lineName: line.name, lineData: line)) {
                                    TFLButton(title: line.name,
                                              tintColor: lineTintColor(for: line.name),
                                              type: "underground",
                                              status: "Status unavailable")
                                }
                            }
                        }
                    }
                    
                    Section("Overground") {
                        if let overgroundLine = tubeData.overgroundData.first,
                           let overgroundStatus = overgroundLine.lineStatuses.first?.statusSeverityDescription {
                            
                            NavigationLink(destination: LinesInfo(lineName: "Overground", lineData: overgroundLine)) {
                                TFLButton(title: "London Overground",
                                          tintColor: Color(red: 238/255.0, green: 124/255.0, blue: 14/255.0),
                                          type: "rail",
                                          status: overgroundStatus)
                            }
                        } else {
                            Text("Status unavailable")
                        }
                    }
                    
                    Section("Other") {
                        if let elizabethLine = tubeData.elizabethData.first,
                           let elizabethLineStatus = elizabethLine.lineStatuses.first?.statusSeverityDescription {
                            NavigationLink(destination: LinesInfo(lineName: "Elizabeth", lineData: elizabethLine)) {
                                TFLButton(title: "Elizabeth Line",
                                          tintColor: Color(red: 113/255.0, green: 86/255.0, blue: 165/255.0),
                                          type: "rail",
                                          status: elizabethLineStatus)
                            }
                        } else {
                            Text("Status unavailable")
                        }
                        
                        if let dlrLine = tubeData.dlrData.first,
                           let dlrStatus = dlrLine.lineStatuses.first?.statusSeverityDescription {
                            NavigationLink(destination: LinesInfo(lineName: "DLR", lineData: dlrLine)) {
                                TFLButton(title: "DLR",
                                          tintColor: Color(red: 0/255.0, green: 164/255.0, blue: 167/255.0),
                                          type: "other",
                                          status: dlrStatus)
                            }
                        } else {
                            Text("Status unavailable")
                        }
                        
                        if let tramLine = tubeData.tramData.first,
                           let tramStatus = tramLine.lineStatuses.first?.statusSeverityDescription {
                            NavigationLink(destination: LinesInfo(lineName: "Tram", lineData: tramLine)) {
                                TFLButton(title: "Trams",
                                          tintColor: Color(red: 132/255.0, green: 184/255.0, blue: 23/255.0),
                                          type: "other",
                                          status: tramStatus)
                            }
                        } else {
                            Text("Status unavailable")
                        }
                    }
                    
                }
                .navigationTitle("TFL Train Status")
                .navigationBarItems(
                    trailing:
                        HStack {
                            lastUpdatedView
                            Button(action: fetchData) {
                                Image(systemName: "arrow.clockwise")
                            }
                        }
                )
            } else {
                Text("Loading...")
                    .navigationTitle("TFL Train Status")
                    .onAppear(perform: fetchData)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            // Refresh data when the app comes back to the foreground
            fetchData()
        }
    }

    // Computed property to display the last updated timestamp
    private var lastUpdatedView: AnyView {
        if let lastUpdated = lastUpdated {
            let formatter = DateFormatter()
            formatter.dateStyle = .none
            formatter.timeStyle = .medium
            let formattedTime = formatter.string(from: lastUpdated)
            return AnyView(
                Text("Last Updated: \(formattedTime)")
                    .foregroundColor(.gray)
                    .font(.caption)
            )
        } else {
            return AnyView(EmptyView())
        }
    }

    // Function to determine tintColor based on line name
    func lineTintColor(for lineID: String) -> Color {
        switch lineID.lowercased() {
        case "bakerloo":
            return Color(red: 179/255.0, green: 99/255.0, blue: 5/255.0)
        case "central":
            return Color(red: 227/255.0, green: 32/255.0, blue: 23/255.0)
        case "circle":
            return Color(red: 255/255.0, green: 211/255.0, blue: 0/255.0)
        case "district":
            return Color(red: 0/255.0, green: 120/255.0, blue: 42/255.0)
        case "hammersmith":
            return Color(red: 243/255.0, green: 169/255.0, blue: 187/255.0)
        case "jubilee":
            return Color(red: 160/255.0, green: 165/255.0, blue: 169/255.0)
        case "metropolitan":
            return Color(red: 155/255.0, green: 0/255.0, blue: 86/255.0)
        case "northern":
            return Color(red: 0/255.0, green: 0/255.0, blue: 0/255.0)
        case "piccadilly":
            return Color(red: 0/255.0, green: 54/255.0, blue: 136/255.0)
        case "victoria":
            return Color(red: 0/255.0, green: 152/255.0, blue: 212/255.0)
        case "waterloo":
            return Color(red: 149/255.0, green: 205/255.0, blue: 186/255.0)
        default:
            return .gray
        }
    }

    func fetchData() {
        guard let url = URL(string: "https://kamrantailor.com/app-tfl/tfl-status") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(TubeData.self, from: data)
                    
                    DispatchQueue.main.async {
                        self.tubeData = decodedData
                        self.lastUpdated = Date() // Update the last updated timestamp
                    }
                } catch {
                    print("JSON Error: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
}




#Preview {
    Status()
}
