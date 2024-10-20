//
//  ContentView.swift
//  Tube Time
//
//  Created by Kamran Tailor on 17/02/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 3 // Start with the third tab (Status) selected
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Search()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass.circle.fill")
                }
                .tag(1)
            
            Local()
                .tabItem {
                    Label("Nearby", systemImage: "mappin.and.ellipse")
                }
                .tag(2) // Tag for identifying the tab
            
            Status() // Make this the default view
                .tabItem {
                    Label("Status", systemImage: "info.circle")
                }
                .tag(3)
            
            Directions()
                .tabItem {
                    Label("Directions", systemImage: "map.circle.fill")
                }
                .tag(4)
            
            
            
            Settings()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.2")
                }
                .tag(5)
        }
        .accentColor(.blue) // Change tab bar's accent color
    }
}
