//
//  Settings.swift
//  Tube Time
//
//  Created by Kamran Tailor on 17/02/2024.
//

import SwiftUI

struct Settings: View {
    @AppStorage("firstName") var firstName: String = ""  // Retrieve first name
    @AppStorage("lastName") var lastName: String = ""  // Retrieve last name
    @AppStorage("email") var email: String = ""
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false  // Track login state

    // Navigation state
    @State private var isLoggingOut: Bool = false

    var body: some View {
        NavigationStack {
            List {
                // Display the user's name at the top
                Section {
                    HStack {
                        InitialsCircleView(firstName: firstName, lastName: lastName)
                        VStack(alignment: .leading) {
                            Text("\(firstName) \(lastName)") // Display full name
                                .font(.headline)
                            Text(email) // Optional welcome message
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                }

                Section(header: Text("Settings")) {
                    NavigationLink(destination: Version()) {
                        HStack {
                            SettingsRowView(imageName: "gear", title: "Version")
                            Spacer()
                            Text("V2.0.0")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }

                Section(header: Text("Info")) {
                    NavigationLink(destination: Sources()) {
                        HStack {
                            SettingsRowView(imageName: "square.and.arrow.down.on.square.fill", title: "Sources")
                        }
                    }
                }

                // Logout Button
                Section(header: Text("Account")) {
                    Button(action: {
                        logout()
                    }) {
                        HStack {
                            SettingsRowView(imageName: "arrow.right.square.fill", title: "Logout")
                        }
                    }
                }
            }
            .navigationTitle("Settings")
            .fullScreenCover(isPresented: $isLoggingOut) {
                LoginView() // Redirect to login view
            }
        }
    }

    func logout() {
        // Clear stored user data
        firstName = ""
        lastName = ""
        isLoggedIn = false

        // Trigger navigation to login view
        isLoggingOut = true
    }
}


struct SettingsRowView: View {
    let imageName: String
    let title: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: imageName)
                .imageScale(.small)
                .font(.title)
                .foregroundColor(iconColor)
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(textColor)
        }
    }
    
    private var iconColor: Color {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                if window.traitCollection.userInterfaceStyle == .dark {
                    return .white // Dark mode, use white color for icons
                }
            }
        }
        return .gray // Light mode, use blue color for icons
    }
    
    private var textColor: Color {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                if window.traitCollection.userInterfaceStyle == .dark {
                    return .white // Dark mode, use white color for text
                }
            }
        }
        return .black // Light mode, use black color for text
    }
}

struct InitialsCircleView: View {
    var firstName: String
    var lastName: String

    var body: some View {
        ZStack {
            // Circle background
            Circle()
                .fill(.gray) // Change color as needed
                .frame(width: 70, height: 70) // Set size of the circle
            
            // Overlay initials
            Text("\(firstInitial())\(secondInitial())")
                .font(.largeTitle) // Set font size
                .foregroundColor(.white) // Change text color
        }
        .padding(0)
    }
    
    // Function to get the first initial of the first name
    private func firstInitial() -> String {
        return firstName.prefix(1).uppercased() // Get first letter and convert to uppercase
    }

    // Function to get the first initial of the last name
    private func secondInitial() -> String {
        return lastName.prefix(1).uppercased() // Get first letter and convert to uppercase
    }
}

#Preview {
    Settings()
}
