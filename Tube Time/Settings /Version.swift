//
//  Version.swift
//  Tube Time
//
//  Created by Kamran Tailor on 25/02/2024.
//

import SwiftUI

struct Version: View {
    var body: some View {
        VStack {
            Text("Version")
                .font(.title)
            Text("V2.0")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .navigationBarTitle("Version", displayMode: .inline)
    }
}

#Preview {
    Version()
}
