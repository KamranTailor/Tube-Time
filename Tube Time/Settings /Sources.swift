//
//  Sources.swift
//  Tube Time
//
//  Created by Kamran Tailor on 25/02/2024.
//

import SwiftUI

struct Sources: View {
    var body: some View {
        Text("Powered by TfL Open Data")
        Text("Contains OS data © Crown copyright and database rights 2016' and Geomni UK Map data © and database rights [2019]")
            .multilineTextAlignment(.center)
            .padding()
    }
}

#Preview {
    Sources()
}
