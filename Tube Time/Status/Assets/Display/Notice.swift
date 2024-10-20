//
//  Notice.swift
//  Tube Time
//
//  Created by Kamran Tailor on 20/10/2024.
//

import SwiftUI

struct NoticeView: View {
    // State variable to control the sheet's visibility
    @State private var showSheet = false
    
    var body: some View {
        let colors = (background: Color(UIColor(red: 228/255, green: 31/255, blue: 31/255, alpha: 1.0)),
                      text: Color.white)
        
        VStack(spacing: 10) {
            ZStack {
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("TFL Cyber Incident")
                            .font(.system(size: 24, weight: .bold, design: .default))
                            .foregroundColor(colors.text)
                            .padding(.leading, 8)
                        
                        Text("Some services currently unavailable")
                            .font(.system(size: 14, weight: .light, design: .default))
                            .foregroundColor(colors.text.opacity(0.9)) // Slightly more vivid text
                            .padding(.leading, 8)
                    }
                    Spacer()
                }
                .padding()
            }
            .frame(maxWidth: .infinity, minHeight: 80, idealHeight: 80, maxHeight: 80)
            .background(colors.background)
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 10)
            .scaleEffect(1)
            .onTapGesture {
                // Show the sheet on tap
                showSheet.toggle()
            }
            .padding(.horizontal, 10)
            .sheet(isPresented: $showSheet) {
                // Sheet content
                SheetView()
            }
        }
    }
}


import SwiftUI

struct SheetView: View {
    @Environment(\.presentationMode) var presentationMode // Add this line

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("TFL Cyber Incident")
                    .font(.title)
                    .fontWeight(.bold) // Make title bold
                    .padding(.top) // Add top padding
                    .padding(.horizontal) // Add horizontal padding
                
                Text("We are currently experiencing some data service disruptions due to a recent cyber incident affecting TFL (Transport for London).")
                    .font(.body)
                    .padding(.horizontal) // Add horizontal padding
                
                Text("TFL is working hard to resolve these issues. Once the data services are back online, we will implement them into the app as soon as we can.")
                    .font(.body)
                    .padding(.horizontal) // Add horizontal padding
                
                Text("The following features are currently unavailable:")
                    .font(.headline) // Use a headline font for emphasis
                    .padding(.horizontal) // Add horizontal padding
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("• Stations View")
                    Text("• Live Stations Arrivals")
                    Text("• Nearby Stations")
                    Text("• Operating Trains")
                    Text("• Crowding Data")
                }
                .font(.body) // Maintain body font style
                .padding(.horizontal) // Add horizontal padding

                Spacer()
            }
            .navigationTitle("Information")
            .navigationBarTitleDisplayMode(.inline) // Set title display mode
            .navigationBarItems(trailing: Button("Close") {
                presentationMode.wrappedValue.dismiss() // Dismiss the sheet
            })
        }
    }
}
