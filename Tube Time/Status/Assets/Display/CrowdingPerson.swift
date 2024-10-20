//
//  CrowdingPerson.swift
//  Tube Time
//
//  Created by Kamran Tailor on 09/10/2024.
//

import SwiftUI

struct CrowdingPerson: View {
    let levelOfCrowding: Int
    
    var body: some View {
        HStack {
            if levelOfCrowding >= 1 {
                Image(systemName: "person.circle.fill")
                    .font(.title2)
                    .foregroundColor(.white)
            }
            
            if levelOfCrowding >= 2 {
                Image(systemName: "person.circle.fill")
                    .font(.title2)
                    .foregroundColor(.white)
            }
            
            if levelOfCrowding >= 3 {
                Image(systemName: "person.circle.fill")
                    .font(.title2)
                    .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    CrowdingPerson(levelOfCrowding: 3)
}
