//
//  LinesInfo.swift
//  Tube Time
//
//  Created by Kamran Tailor on 17/02/2024.
//

import SwiftUI

struct LinesInfo: View {
    var lineId: String
    @State private var lineData: LineData?
    @State private var isLoading = true
    
    @State private var isPopupPresented = false
    
    var body: some View {
        ZStack {
            Color(.systemBackground).edgesIgnoringSafeArea(.all)
            
            NavigationStack {
                ScrollView {
                    VStack(alignment: .center, spacing: 20) {
                        if isLoading {
                            loadingView
                        } else if let lineData = lineData {
                            lineInfoView(lineData: lineData)
                            HStack {
                                stationsView(stations: lineData.stations, stationLengths: lineData.amoutOfStations, lineName: lineData.name)
                                operatingTrains(operatingTrainsAmmout: nil)
                            }
                            crowdingView(crowding: lineData.crowding)
                        } else {
                            Text("Failed to load data.")
                                .font(.headline)
                                .foregroundColor(.red)
                        }
                        Spacer()
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
                .onAppear(perform: fetchTFLStatus)
            }
        }
    }
    
    private var loadingView: some View {
        HStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                .scaleEffect(1.5)
            Text("Loading data...")
                .font(.headline)
                .foregroundColor(.white)
        }
    }
    
    @ViewBuilder
    private func lineInfoView(lineData: LineData) -> some View {
        let colors = LineColors.getColors(for: lineData.name)
        VStack(alignment: .center, spacing: 12) {
            Text(lineData.name)
                .padding(.top)
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundColor(colors.text)
            
            let statusDescription = LineColors.getName(lineStatus: lineData.lineStatus.lineStatuses.first?.statusSeverityDescription ?? "Unknown")
            
            Text(statusDescription)
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(colors.text)
                .padding(.bottom)
            
            let disruptions = lineData.lineStatus.lineStatuses.filter { $0.statusSeverity != 10 }
            if !disruptions.isEmpty {
                ForEach(disruptions, id: \.statusSeverity) { status in
                    if let reason = status.reason {
                        disruptionView(reason: reason, textColor: colors.text, backgroundColor: colors.background)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(colors.background)
                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 10)
        )
    }

    private func disruptionView(reason: String, textColor: Color, backgroundColor: Color) -> some View {
        Text(reason)
            .font(.subheadline)
            .foregroundColor(textColor)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(backgroundColor)
            )
    }

    private func crowdingView(crowding: Crowding?) -> some View {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: "person.3.fill")
                        .font(.title2)
                        .foregroundColor(.primary)
                    
                    Text("Crowding")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)

                    Spacer()
                }

                if let crowdingLevel = crowding?.level {
                    Text("Crowding Level: \(crowdingLevel)")
                        .font(.subheadline)
                        .foregroundColor(.primary.opacity(0.8))
                } else {
                    VStack {
                        Text("Crowding Data Currently Unavailable")
                            .font(.subheadline)
                            .foregroundColor(.red)
                            .underline()
                            .onTapGesture {
                                isPopupPresented = true
                            }
                    }
                }
            }
            .padding()
            .background(Color(.systemGray5))
            .cornerRadius(16)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
        }

    private func stationsView(stations: [LineStation], stationLengths: Int, lineName: String) -> some View {
            VStack(alignment: .leading, spacing: 12) {
                Text("\(stationLengths)")
                    .font(.system(size: 56, weight: .heavy))
                    .foregroundColor(.primary)

                Text("Total Stations")
                    .font(.subheadline)
                    .foregroundColor(.primary.opacity(0.75))

                NavigationLink(destination: TotalStations(stations: stations, lineName: lineName)) {
                    HStack(spacing: 14) {
                        Text("View All")
                            .font(.headline)
                            .foregroundColor(.white)
                        Image(systemName: "chevron.right")
                            .imageScale(.small)
                            .foregroundColor(.white)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color.blue)
                    .cornerRadius(12)
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(false)

            }
            .padding()
            .background(Color(.systemGray5))
            .cornerRadius(16)
            .frame(maxWidth: .infinity)
        }
    
    private func operatingTrains(operatingTrainsAmmout: Int?) -> some View {
            VStack(alignment: .leading, spacing: 12) {
                
                if ((operatingTrainsAmmout) != nil) {
                    Text("\(operatingTrainsAmmout ?? 13)")
                        .font(.system(size: 56, weight: .heavy))
                        .foregroundColor(.primary)
                    
                    Text("Operating Trains")
                        .font(.subheadline)
                        .foregroundColor(.primary.opacity(0.75))
                    
                    NavigationLink(destination: OperatingTrains()) {
                        HStack(spacing: 14) {
                            Text("View All")
                                .font(.headline)
                                .foregroundColor(.white)
                            Image(systemName: "chevron.right")
                                .imageScale(.small)
                                .foregroundColor(.white)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(Color.blue)
                        .cornerRadius(12)
                    }
                } else {
                    VStack {
                        Text("Live Data Currently Unavailable")
                            .font(.subheadline)
                            .foregroundColor(.red)
                            .underline()
                            .onTapGesture {
                                isPopupPresented = true
                            }
                    }
                    
                    Text("Operating Trains")
                        .font(.subheadline)
                        .foregroundColor(.primary.opacity(0.75))
                    
                    HStack(spacing: 14) {
                        Text("View All")
                            .font(.headline)
                            .foregroundColor(.white)
                        Image(systemName: "chevron.right")
                            .imageScale(.small)
                            .foregroundColor(.white)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color.gray)
                    .cornerRadius(12)
                }
            }
            .padding()
            .background(Color(.systemGray5))
            .cornerRadius(16)
            .frame(maxWidth: .infinity)
        }

    private func fetchTFLStatus() {
        guard let url = URL(string: "https://kamrantailor.com/app-tfl/tfl-status-line?id=\(lineId)") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                DispatchQueue.main.async { isLoading = false }
                return
            }
            
            do {
                let lineData = try JSONDecoder().decode(LineData.self, from: data)
                DispatchQueue.main.async {
                    self.lineData = lineData
                    self.isLoading = false
                }
            } catch {
                print("Error decoding JSON: \(error)")
                DispatchQueue.main.async { isLoading = false }
            }
        }.resume()
    }
}

