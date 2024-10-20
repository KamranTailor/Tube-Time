//
//  Tube_TimeApp.swift
//  Tube Time
//
//  Created by Kamran Tailor on 17/02/2024.
//

import SwiftUI

@main
struct Tube_TimeApp: App {
    @StateObject var locationManger = LocationManager()

    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(locationManger)
        }
    }
}
