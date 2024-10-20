//
//  lineColour.swift
//  Tube Time
//
//  Created by Kamran Tailor on 08/10/2024.
//

import Foundation
import SwiftUI

struct LineColors {
    static func getColors(for lineName: String) -> (background: Color, text: Color) {
        switch lineName {
        case "Bakerloo":
            return (background: Color(UIColor(red: 174/255, green: 97/255, blue: 24/255, alpha: 1.0)),
                    text: Color.white)
        case "Central":
            return (background: Color(UIColor(red: 228/255, green: 31/255, blue: 31/255, alpha: 1.0)),
                    text: Color.white)
        case "Circle":
            return (background: Color(UIColor(red: 248/255, green: 212/255, blue: 45/255, alpha: 1.0)),
                    text: Color.black)
        case "District":
            return (background: Color(UIColor(red: 0/255, green: 114/255, blue: 41/255, alpha: 1.0)),
                    text: Color.white)
        case "DLR":
            return (background: Color(UIColor(red: 0/255, green: 187/255, blue: 180/255, alpha: 1.0)),
                    text: Color.black)
        case "Hammersmith & City":
            return (background: Color(UIColor(red: 232/255, green: 153/255, blue: 168/255, alpha: 1.0)),
                    text: Color.black)
        case "Jubilee":
            return (background: Color(UIColor(red: 104/255, green: 110/255, blue: 114/255, alpha: 1.0)),
                    text: Color.white)
        case "Metropolitan":
            return (background: Color(UIColor(red: 137/255, green: 50/255, blue: 103/255, alpha: 1.0)),
                    text: Color.white)
        case "Northern":
            return (background: Color(UIColor(red: 68/255, green: 68/255, blue: 68/255, alpha: 1.0)),
                    text: Color.white)
        case "Piccadilly":
            return (background: Color(UIColor(red: 4/255, green: 80/255, blue: 161/255, alpha: 1.0)),
                    text: Color.white)
        case "Victoria":
            return (background: Color(UIColor(red: 0/255, green: 159/255, blue: 224/255, alpha: 1.0)),
                    text: Color.black)
        case "Waterloo & City":
            return (background: Color(UIColor(red: 112/255, green: 195/255, blue: 206/255, alpha: 1.0)),
                    text: Color.black)
        case "London Overground":
            return (background: Color(UIColor(red: 255/255, green: 134/255, blue: 0/255, alpha: 1.0)),
                    text: Color.black)
        case "Tram":
            return (background: Color(UIColor(red: 118/255, green: 188/255, blue: 33/255, alpha: 1.0)),
                    text: Color.white)
        case "Elizabeth line":
            return (background: Color(UIColor(red: 105/255, green: 80/255, blue: 161/255, alpha: 1.0)),
                    text: Color.white)
        default:
            return (background: Color.gray, text: Color.black)
        }
    }

    
    static func getName(lineStatus: String) -> String {
        let statusIcons: [String: String] = [
            "Special Service": "⚠️ Special Service",
            "Closed": "⛔️ Closed",
            "Suspended": "⛔️ Suspended",
            "Part Suspended": "⛔️ Part Suspended",
            "Planned Closure": "🏗️ Planned Closure",
            "Part Closure": "⛔️ Part Closure",
            "Severe Delays": "⚠️ Severe Delays",
            "Reduced Service": "⚠️ Reduced Service",
            "Bus Service": "🚌 Bus Service",
            "Minor Delays": "⚠️ Minor Delays",
            "Good Service": "✅ Good Service"
        ]
        return statusIcons[lineStatus] ?? lineStatus
    }
}
