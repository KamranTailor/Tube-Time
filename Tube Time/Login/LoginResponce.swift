//
//  LoginResponce.swift
//  Tube Time
//
//  Created by Kamran Tailor on 20/10/2024.
//

import Foundation

struct LoginResponse: Codable {
    let status: Bool
    let message: String
    let user: User
}

struct User: Codable {
    let email: String
    let firstName: String
    let lastName: String
}

