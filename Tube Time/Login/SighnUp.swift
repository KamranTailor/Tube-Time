//
//  SignUp.swift
//  Tube Time
//
//  Created by Kamran Tailor on 20/10/2024.
//
import SwiftUI

struct SignUp: View {
    @AppStorage("email") var email: String = ""  // Persisted in UserDefaults
    @AppStorage("firstName") var firstName: String = ""  // Persisted in UserDefaults
    @AppStorage("lastName") var lastName: String = ""  // Persisted in UserDefaults
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false  // Persisted in UserDefaults
    
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var firstNameInput: String = ""
    @State private var lastNameInput: String = ""
    @State private var loginError: String? = nil
    @EnvironmentObject var locationManager: LocationManager

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
                ContentView()
                    .environmentObject(locationManager)
            } else {
                VStack {
                    Text("Create An Account")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 50)
                    
                    VStack(spacing: 20) {
                        // First Name input
                        CustomTextField(placeholder: "First Name", text: $firstNameInput)
                        
                        // Last Name input
                        CustomTextField(placeholder: "Last Name", text: $lastNameInput)
                        
                        // Email input
                        CustomTextField(placeholder: "Email", text: $email, isEmail: true)
                        
                        // Password input
                        CustomSecureField(placeholder: "Password", text: $password)
                        
                        // Confirm Password input
                        CustomSecureField(placeholder: "Confirm Password", text: $confirmPassword)
                        
                        if let error = loginError {
                            Text(error)
                                .font(.footnote)
                                .foregroundColor(.red)
                        }
                        
                        // Sign Up button
                        Button(action: {
                            signUp()
                        }) {
                            Text("Sign Up")
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(
                                            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing)
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
                }
            }
        }
    }

    func signUp() {
        // Basic validation
        guard !firstNameInput.isEmpty, !lastNameInput.isEmpty, !email.isEmpty, !password.isEmpty, password == confirmPassword else {
            loginError = "Please fill in all fields and ensure passwords match."
            return
        }

        // Example regex for email validation
        let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailPattern)
        if !emailPredicate.evaluate(with: email) {
            loginError = "Invalid email format."
            return
        }
        
        // Proceed with the signup process
        guard let url = URL(string: "https://kamrantailor.com/app/sighnUp") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let bodyData = "email=\(email)&password=\(password)&confirmPassword=\(confirmPassword)&firstName=\(firstNameInput)&lastName=\(lastNameInput)"
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
                
                if let data = data, let responseBody = String(data: data, encoding: .utf8) {
                    print("Response Body: \(responseBody)")
                }
                
                switch httpResponse.statusCode {
                case 200:
                    // Successful signup
                    DispatchQueue.main.async {
                        email = email
                        firstName = firstNameInput
                        lastName = lastNameInput
                        isLoggedIn = true
                    }
                case 400:
                    DispatchQueue.main.async {
                        loginError = "Error: Please check your input."
                    }
                case 500:
                    DispatchQueue.main.async {
                        loginError = "Server error, please try again later."
                    }
                default:
                    DispatchQueue.main.async {
                        loginError = "Unexpected server response: \(httpResponse.statusCode)"
                    }
                }
            } else {
                DispatchQueue.main.async {
                    loginError = "Unexpected server response."
                }
            }
        }
        task.resume()
    }
}

// Custom TextField with a rounded background
struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    var isEmail: Bool = false // Optional email validation
    
    var body: some View {
        TextField(placeholder, text: $text)
            .textFieldStyle(PlainTextFieldStyle())
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white.opacity(0.2))
            )
            .padding(.horizontal)
            .foregroundColor(.white)
            .autocapitalization(isEmail ? .none : .words)
            .disableAutocorrection(true)
    }
}

// Custom SecureField with a rounded background
struct CustomSecureField: View {
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        SecureField(placeholder, text: $text)
            .textFieldStyle(PlainTextFieldStyle())
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white.opacity(0.2))
            )
            .padding(.horizontal)
            .foregroundColor(.white)
    }
}

