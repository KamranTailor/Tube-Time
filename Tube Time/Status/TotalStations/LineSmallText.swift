//
//  LineSmallText.swift
//  Tube Time
//
//  Created by Kamran Tailor on 12/10/2024.
//

import SwiftUI

struct LineSmallText: View {
    let name: String
    @State private var colour: Color = Color(UIColor(red: 208/255, green: 26/255, blue: 30/255, alpha: 1.0)) // Default color
    
    var body: some View {
        let colour = getColorForLine(name: name) // Call function to set background color
        let textColor = getTextColorForLine(name: name) // Call function to get text color
        let shortName = getShortNameForLine(name: name) // Call function to get shortened name
        
        Text(shortName)
            .font(.subheadline)
            .foregroundColor(textColor) // Apply dynamic text color
            .padding(10)
            .background(colour)
            .cornerRadius(5)
    }
    
    // Function to return the color for each line
    private func getColorForLine(name: String) -> Color {
        switch name {
        case "Bakerloo":
            return Color(UIColor(red: 174/255, green: 97/255, blue: 24/255, alpha: 1.0))
        case "Central":
            return Color(UIColor(red: 228/255, green: 31/255, blue: 31/255, alpha: 1.0))
        case "Circle":
            return Color(UIColor(red: 248/255, green: 212/255, blue: 45/255, alpha: 1.0))
        case "District":
            return Color(UIColor(red: 0/255, green: 114/255, blue: 41/255, alpha: 1.0))
        case "DLR":
            return Color(UIColor(red: 0/255, green: 187/255, blue: 180/255, alpha: 1.0))
        case "Hammersmith & City":
            return Color(UIColor(red: 232/255, green: 153/255, blue: 168/255, alpha: 1.0))
        case "Jubilee":
            return Color(UIColor(red: 104/255, green: 110/255, blue: 114/255, alpha: 1.0))
        case "Metropolitan":
            return Color(UIColor(red: 137/255, green: 50/255, blue: 103/255, alpha: 1.0))
        case "Northern":
            return Color(UIColor(red: 68/255, green: 68/255, blue: 68/255, alpha: 1.0))
        case "Piccadilly":
            return Color(UIColor(red: 4/255, green: 80/255, blue: 161/255, alpha: 1.0))
        case "Victoria":
            return Color(UIColor(red: 0/255, green: 159/255, blue: 224/255, alpha: 1.0))
        case "Waterloo & City":
            return Color(UIColor(red: 112/255, green: 195/255, blue: 206/255, alpha: 1.0))
        case "London Overground":
            return Color(UIColor(red: 255/255, green: 134/255, blue: 0/255, alpha: 1.0))
        case "Tram":
            return Color(UIColor(red: 118/255, green: 188/255, blue: 33/255, alpha: 1.0))
        case "Elizabeth line":
            return Color(UIColor(red: 105/255, green: 80/255, blue: 161/255, alpha: 1.0))
        default:
            return Color(UIColor(red: 208/255, green: 26/255, blue: 30/255, alpha: 1.0))
        }
    }
    
    // Function to return the dynamic text color for each line
    private func getTextColorForLine(name: String) -> Color {
        switch name {
        case "Circle", "DLR", "Hammersmith & City", "Victoria", "Waterloo & City", "London Overground":
            return Color.black // Use black text for lighter backgrounds
        default:
            return Color.white // Use white text for darker backgrounds
        }
    }
    
    // Function to return a shortened three-letter version of the line name
    private func getShortNameForLine(name: String) -> String {
        switch name {
        case "Bakerloo": return "BKL"
        case "Central": return "CEN"
        case "Circle": return "CIR"
        case "District": return "DIS"
        case "DLR": return "DLR"
        case "Hammersmith & City": return "H&C"
        case "Jubilee": return "JUB"
        case "Metropolitan": return "MET"
        case "Northern": return "NOR"
        case "Piccadilly": return "PIC"
        case "Victoria": return "VIC"
        case "Waterloo & City": return "W&C"
        case "London Overground": return "LO"
        case "Tram": return "TRM"
        case "Elizabeth line": return "ELI"
        default: return name // Fallback if unknown
        }
    }
}

#Preview {
    LineSmallText(name: "Central")
}
