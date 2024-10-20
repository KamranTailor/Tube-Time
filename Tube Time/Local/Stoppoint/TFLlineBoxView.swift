//
//  TFLlineBoxView.swift
//  Tube Time
//
//  Created by Kamran Tailor on 06/10/2024.
//


import SwiftUI

struct TFLlineBoxView: View {
    let lineId: String
    let lineStatusDescription: String
    
    var body: some View {
        VStack {
            Text(lineId)
                .font(.headline)
                .padding(.top, 10)
            Text(lineStatusDescription)
                .font(.subheadline)
                .padding(.bottom, 10)
        }
        .frame(width: 300, height: 150) // Set the width and height of the box
        .background(Color.blue) // Set the background color of the box
        .cornerRadius(10) // Rounded corners
        .shadow(radius: 5) // Add some shadow for depth
        .padding() // Add padding around the box
    }
}

#Preview {
    TFLlineBoxView(lineId: "Central Line", lineStatusDescription: "Good Service")
}
