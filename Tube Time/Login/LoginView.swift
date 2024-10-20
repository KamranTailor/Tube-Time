//
//  LoginView.swift
//  Tube Time
//
//  Created by Kamran Tailor on 20/10/2024.
//

import SwiftUI

struct LoginView: View {
    @AppStorage("email") var email: String = ""  // Persisted in UserDefaults
    @AppStorage("firstName") var firstName: String = ""  // Persisted in UserDefaults
    @AppStorage("lastName") var lastName: String = ""  // Persisted in UserDefaults
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false  // Persisted in UserDefaults
    @State private var password: String = ""
    @State private var loginError: String? = nil
    @EnvironmentObject var locationManager: LocationManager
    @State private var showingSighnUp = false
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                            gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.7)]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .ignoresSafeArea()

            if isLoggedIn {
                // If the user is logged in, show the main content view
                ContentView()
                    .environmentObject(locationManager)
            } else {
                // Otherwise, show the login form
                VStack {
                    Text("Welcome To Tube Time")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 50)
                    
                    Text("Your companion for traveling in London")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    VStack(spacing: 20) {
                        // Email input
                        TextField("Email", text: $email)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.white.opacity(0.2))
                            )
                            .padding(.horizontal)
                            .foregroundColor(.white)
                            .autocapitalization(.none) // Prevents auto-capitalization
                            .disableAutocorrection(true) // Optional: Disables autocorrection if desired

                        // Password input
                        SecureField("Password", text: $password)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.white.opacity(0.2))
                            )
                            .padding(.horizontal)
                            .foregroundColor(.white)

                        if let error = loginError {
                            Text(error)
                                .font(.footnote)
                                .foregroundColor(.red)
                        }

                        // Login button
                        Button(action: {
                            login()
                        }) {
                            Text("Login")
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(
                                            LinearGradient(
                                                gradient: Gradient(colors: [Color.blue, Color.purple]),
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )
                                )
                                .shadow(color: Color.blue.opacity(0.5), radius: 10, x: 0, y: 5)
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal)
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)

                    Spacer()

                    // Sign-up link
                    HStack {
                        Text("Don't have an account?")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Button(action: {
                            showingSighnUp.toggle()
                        }) {
                            Text("Sign Up")
                                .fontWeight(.bold)
                                .foregroundColor(Color.blue)
                        }
                        .sheet(isPresented: $showingSighnUp) {
                            SignUp()
                        }
                    }
                    .padding(.bottom, 20)
                }
                .padding(.horizontal)
            }
        }
    }

    func login() {
        guard let url = URL(string: "https://kamrantailor.com/app/login") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let bodyData = "email=\(email)&password=\(password)"  // Use @AppStorage email
        request.httpBody = bodyData.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                DispatchQueue.main.async {
                    loginError = "Unable to connect to server"
                }
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse)
                
                // Attempt to log the response body
                if let data = data, let responseBody = String(data: data, encoding: .utf8) {
                    print("Response Body: \(responseBody)")  // Log the response body
                }
                
                switch httpResponse.statusCode {
                case 200:
                    // Successful login
                    if let data = data {
                        do {
                            // Decode the server response using LoginResponse
                            let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)

                            // Update @AppStorage variables with the decoded data
                            DispatchQueue.main.async {
                                email = loginResponse.user.email
                                firstName = loginResponse.user.firstName
                                lastName = loginResponse.user.lastName
                                isLoggedIn = true  // Update the login state
                            }
                        } catch {
                            DispatchQueue.main.async {
                                loginError = "Error decoding server response: \(error.localizedDescription)"
                            }
                        }
                    }
                case 400:
                    // Incorrect username or password
                    DispatchQueue.main.async {
                        loginError = "Invalid email or password"
                    }
                case 500:
                    // Server error
                    DispatchQueue.main.async {
                        loginError = "Server error, please try again later"
                    }
                default:
                    // Handle other response codes
                    DispatchQueue.main.async {
                        loginError = "Unexpected server response: \(httpResponse.statusCode)"
                    }
                }
            } else {
                DispatchQueue.main.async {
                    loginError = "Unexpected server response"
                }
            }
        }
        task.resume()
    }
}
