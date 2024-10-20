//
//  NextArrival.swift
//  Tube Time
//
//  Created by Kamran Tailor on 19/09/2024.
//

import SwiftUI

struct NextArrival: View {
    let arrivals: [ArrivalItem]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Next Arrivals")
                .font(.headline)
                .padding(.bottom, 5)
            
            ForEach(arrivals) { arrival in
                HStack {
                    Text(arrival.title)
                        .font(.subheadline)
                    Spacer()
                    Text(dateFormatter.string(from: arrival.date))
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 2)
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(8)
        .shadow(radius: 4)
    }
}

struct ArrivalItem: Identifiable {
    let id = UUID()
    let title: String
    let date: Date
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
}()
