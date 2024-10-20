import SwiftUI

struct Status: View {
    @State private var disruptionPresent: [TFLlineBoxView] = []
    @State private var linesStatus: [TFLlineBoxView] = [] // Tube lines
    @State private var overgroundLines: [TFLlineBoxView] = [] // Change to TFLlineBoxView for overground lines
    @State private var otherLines: [TFLlineBoxView] = []
    
    var body: some View {
        NavigationStack { // Place NavigationView at the top level
            ScrollView {
                VStack(alignment: .leading) {
                    
                    NoticeView()
                    
                    // Disruptions Section
                    if !disruptionPresent.isEmpty {
                        SectionView(header: "Disruptions Present", items: disruptionPresent)
                    }
                    
                    // Tube Lines Section
                    if !linesStatus.isEmpty {
                        SectionView(header: "Tube Lines", items: linesStatus)
                    }
                    
                    // Overground Lines Section
                    if !overgroundLines.isEmpty {
                        SectionView(header: "Overground Lines", items: overgroundLines)
                    }
                    
                    // Other Lines Section
                    if !otherLines.isEmpty {
                        SectionView(header: "Other Lines", items: otherLines)
                    }
                }
                .onAppear {
                    fetchTFLStatus() // Fetch data on appear
                }
            }
            .navigationTitle("Current Status") // Set a navigation title
        }
    }

    // Reusable SectionView for modern look
    struct SectionView: View {
        let header: String
        let items: [TFLlineBoxView]
        
        var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                Text(header)
                    .font(.headline)
                    .foregroundColor(.accentColor)
                    .padding(.leading)
                
                ForEach(items, id: \.lineId) { lineStatus in
                    lineStatus

                }
            }
            .padding(.top, 20)
        }
    }

    private func fetchTFLStatus() {
        guard let url = URL(string: "https://kamrantailor.com/app-tfl/tfl-status") else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let transportDataArray = try JSONDecoder().decode([TransportData].self, from: data)

                // Assuming you want to access the first object in the array
                if let firstTransportData = transportDataArray.first {
                    var disruptionPresent: [TFLlineBoxView] = []
                    var tubeStatuses: [TFLlineBoxView] = [] // Change to TFLlineBoxView
                    var overgroundStatuses: [TFLlineBoxView] = [] // Change to TFLlineBoxView
                    var otherLineStatuses: [TFLlineBoxView] = []
                    
                    // Extract line status information for tubeData
                    for line in firstTransportData.tubeData {
                        if let firstStatus = line.lineStatuses.first {
                            let card = TFLlineBoxView(
                                lineId: line.id,
                                lineName: line.name,
                                lineStatusDescription: firstStatus.statusSeverityDescription ?? "N/A"
                            )
                            
                            if firstStatus.statusSeverityDescription != "Good Service" {
                                disruptionPresent.append(card)
                            } else {
                                tubeStatuses.append(card)
                            }
                        }
                    }

                    // Extract line status information for overgroundData
                    for line in firstTransportData.overgroundData {
                        if let firstStatus = line.lineStatuses.first {
                            let card = TFLlineBoxView(
                                lineId: line.id,
                                lineName: line.name,
                                lineStatusDescription: firstStatus.statusSeverityDescription ?? "N/A"
                            )
                            
                            if firstStatus.statusSeverityDescription != "Good Service" {
                                disruptionPresent.append(card)
                            } else {
                                overgroundStatuses.append(card)
                            }
                        }
                    }

                    // Process Elizabeth Line Data
                    if let firstLine = firstTransportData.elizabethData.first,
                       let firstStatus = firstLine.lineStatuses.first {
                        let card = TFLlineBoxView(
                            lineId: firstLine.id,
                            lineName: firstLine.name,
                            lineStatusDescription: firstStatus.statusSeverityDescription ?? "N/A"
                        )
                        
                        if firstStatus.statusSeverityDescription != "Good Service" {
                            disruptionPresent.append(card)
                        } else {
                            otherLineStatuses.append(card)
                        }
                    }

                    // Process DLR Data
                    if let firstDLRLine = firstTransportData.dlrData.first,
                       let firstDLRStatus = firstDLRLine.lineStatuses.first {
                        let dlrCard = TFLlineBoxView(
                            lineId: firstDLRLine.id,
                            lineName: firstDLRLine.name,
                            lineStatusDescription: firstDLRStatus.statusSeverityDescription ?? "N/A"
                        )
                        
                        if firstDLRStatus.statusSeverityDescription != "Good Service" {
                            disruptionPresent.append(dlrCard)
                        } else {
                            otherLineStatuses.append(dlrCard)
                        }
                    }

                    // Process Tram Data
                    if let firstTramLine = firstTransportData.tramData.first,
                       let firstTramStatus = firstTramLine.lineStatuses.first {
                        let tramCard = TFLlineBoxView(
                            lineId: firstTramLine.id,
                            lineName: firstTramLine.name,
                            lineStatusDescription: firstTramStatus.statusSeverityDescription ?? "N/A"
                        )
                        
                        if firstTramStatus.statusSeverityDescription != "Good Service" {
                            disruptionPresent.append(tramCard)
                        } else {
                            otherLineStatuses.append(tramCard)
                        }
                    }


                    DispatchQueue.main.async {
                        self.linesStatus = tubeStatuses
                        self.overgroundLines = overgroundStatuses
                        self.otherLines = otherLineStatuses
                        self.disruptionPresent = disruptionPresent
                    }
                } else {
                    print("No transport data available")
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }

        task.resume() // Start the data task
    }
}

#Preview {
    Status()
}
