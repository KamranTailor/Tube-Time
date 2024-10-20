//
//  Search.swift
//  Tube Time
//
//  Created by Kamran Tailor on 12/10/2024.
//

import SwiftUI

struct Search: View {
    @State private var searchText = ""
    
    var filteredStations: [StoppointStation] {
        if searchText.isEmpty {
            return stoppointStations
        } else {
            return stoppointStations.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var limitedStations: [StoppointStation] {
        Array(filteredStations.prefix(15)) // Limit to 15 stations
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                SearchBar(text: $searchText)
                List(limitedStations) { station in
                    NavigationLink(destination: StationView(id: station.code)) {
                        VStack(alignment: .leading) {
                            Text(station.name)
                                .font(.headline)
                            Text(station.code)
                                .font(.subheadline)
                        }
                    }
                }
            }
            .navigationTitle("Find a station")
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding(.leading, 8)
                        Spacer()
                    }
                )
                .padding(.horizontal, 10)
        }
        .padding(.top, 10)
    }
}

#Preview {
    Search()
}
