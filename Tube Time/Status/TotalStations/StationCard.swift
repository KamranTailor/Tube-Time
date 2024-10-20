//
//  StationCard.swift
//  Tube Time
//
//  Created by Kamran Tailor on 12/10/2024.
//

import SwiftUI

struct StationCard: View {
    let station: LineStation
    
    var body: some View {
        NavigationLink(destination: StationView(id: station.id)) {
            ZStack {
                VStack(alignment: .leading) { // Aligns the VStack contents to the leading edge (top-left)
                    HStack {
                        Text(station.commonName)
                            .font(.headline) // Headline font for emphasis
                            .foregroundColor(.primary) // Primary color for text
                            .padding(.vertical, 10) // Vertical padding for the text
                            .padding(.horizontal) // Horizontal padding
                            .lineLimit(nil) // Allow text to wrap onto the next line
                            .frame(maxWidth: .infinity) // Ensure the text frame expands to full width
                            .cornerRadius(10) // Rounded corners for the text background
                            .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2) // Subtle shadow for depth
                    }
                    
                    HStack {
                        // Display the first 5 lines
                        ForEach(station.lines.prefix(4).indices, id: \.self) { index in
                            LineSmallText(name: station.lines[index].name)
                        }
                        
                        // If there are more than 5 lines, display "X+ more"
                        if station.lines.count > 4 {
                            Text("\(station.lines.count - 4)+ more")
                                .font(.subheadline)
                                .foregroundColor(.gray) // Optional styling
                                .padding(.leading, 5) // Add some space between the last line and the "more" text
                        }
                    }
                    
                    .padding(.top, 5) // Padding above the HStack
                }
                .padding() // Padding for the entire card
                .background(Color(.systemGray4)) // Card background color
                .cornerRadius(15) // Rounded corners for the card
                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 3) // Shadow for card depth
            }
            .frame(maxWidth: .infinity, minHeight: 100)
            .padding(.top)
        }
    }
}
