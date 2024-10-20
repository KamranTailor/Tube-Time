//
//  TflButton.swift
//  Tube Time
//
//  Created by Kamran Tailor on 17/02/2024.
//

import SwiftUI

struct TFLButton: View {
    let title: String
    let tintColor: Color
    let type: String
    let imageName: String
    let status: String
    
    @Environment(\.colorScheme) var colorScheme
    
    init(title: String, tintColor: Color, type: String, status: String) {
        self.title = title
        self.tintColor = tintColor
        self.type = type
        self.status = status
        
        // Set imageName based on type
        if type == "underground" {
            imageName = "tram.fill.tunnel"
        } else if type == "rail" {
            imageName = "train.side.front.car"
        } else {
            imageName = "tram"
        }
    }
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .imageScale(.small)
                .font(.title)
                .foregroundColor(tintColor)
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(colorScheme == .dark ? .white : .black)
            
            Spacer() // Add Spacer to push the status to the right
            
            Text(status)
                .font(.subheadline)
                .foregroundColor(statusColor())
        }
    }
    
    private func statusColor() -> Color {
        if status == "Suspended" {
            return .red
        } else if  status == "Part Suspended" {
            return .green
        }  else if  status == "Planned Closure" {
            return .orange
        }  else if status == "Part Closure" {
            return .green
        }  else if  status == "Severe Delays" {
            return .red
        } else if status == "Reduced Service" {
            return .yellow
        } else if status == "Bus Service" {
            return .yellow
        } else if status == "Minor Delays" {
            return .orange
        } else {
            return colorScheme == .dark ? .white : .black
        }
    }
    
}

#Preview {
    TFLButton( title: "Version", tintColor: Color(.systemGray), type: "Train", status: "Good Service")
}
