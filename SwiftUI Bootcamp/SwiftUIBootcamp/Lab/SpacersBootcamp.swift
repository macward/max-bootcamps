//
//  SpacersBootcamp.swift
//  SwiftUIBootcamp
//
//  Created by Max on 18/06/2024.
//

import SwiftUI

struct SpacersBootcamp: View {
    var body: some View {
        VStack {
            Group {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(Color.accentColor)
                Text("Hello, World!")
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .debugViewLimit()
    }
}

//Spacer(minLength: 30) // pushup view
//Color.red // pushup views

#Preview {
    SpacersBootcamp()
}
