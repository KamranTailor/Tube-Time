//
//  TFLlineBoxView.swift
//  Tube Time
//
//  Created by Kamran Tailor on 06/10/2024.
//

import SwiftUI

struct TFLlineBoxView: View {
    let lineId: String
    let lineName: String
    let lineStatusDescription: String
    @State private var showActionPopup = false
    
    var body: some View {
        let colors = LineColors.getColors(for: lineName)
        let modifiedLineStatusDescription = LineColors.getName(lineStatus: lineStatusDescription) // Updated call
        
        VStack(spacing: 10) {
            ZStack {
                NavigationLink(destination: LinesInfo(lineId: lineId)) {
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(lineName)
                                .font(.system(size: 24, weight: .bold, design: .default))
                                .foregroundColor(colors.text)
                                .padding(.leading, 8)
                            
                            Text(modifiedLineStatusDescription)
                                .font(.system(size: 14, weight: .light, design: .default))
                                .foregroundColor(colors.text.opacity(0.9)) // Slightly more vivid text
                                .padding(.leading, 8)
                        }
                        Spacer()
                    }
                    .onLongPressGesture(minimumDuration: 0.5) {
                        // Trigger haptic feedback on long press
                        let haptic = UIImpactFeedbackGenerator(style: .heavy)
                        haptic.impactOccurred()
                        
                        // Show action popup
                        withAnimation {
                            showActionPopup = true
                        }
                    }
                    .padding()
                }
            }
            .frame(maxWidth: .infinity, minHeight: 80, idealHeight: 80, maxHeight: 80)
            .background(colors.background)
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 10)
            .scaleEffect(1)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.3)) {
                    // Bounce effect on tap
                }
            }
            .padding(.horizontal, 10)
            
            // Action popup view
            if showActionPopup {
                HStack {
                    Button(action: {
                        // Pin action logic here
                        print("Pin Action Triggered")
                        withAnimation {
                            showActionPopup = false
                        }
                    }) {
                        Text("Pin")
                            .padding()
                            .frame(width: 100)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        showActionPopup = false
                    }) {
                        Text("Cancel")
                            .padding()
                            .frame(width: 100)
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .transition(.move(edge: .bottom)) // Animation transition for the popup
                .padding(.top, 5)
            }
        }
    }
}

#Preview {
    TFLlineBoxView(lineId: "central", lineName: "Central", lineStatusDescription: "Good Service")
}
