//
//  EnvironmentTestView.swift
//  SwiftUIBootcamp
//
//  Created by Max Ward on 08/10/2023.
//

import SwiftUI

struct EnvironmentTestView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var MainView: some View {
//        if colorScheme == .dark { // Checks the wrapped value.
//            Text("Dark scheme")
//        } else {
//            Text("Light scheme")
//                .onTapGesture {
//                    dismiss()
//                }
//        }
        Text("sample")
            
    }
    
    var body: some View {
        MainView
    }
}

#Preview {
    EnvironmentTestView()
}

struct ContentView: View {
    var body: some View {
      List {
        Text("Hello World")
                    .bold() // .bold() is a modifier
                    .foregroundColor(.blue) // modifier: set foreground color
                    .blur(radius: 1, opaque: false) // modifier: set blur
        }
    }
}


struct BodyFont: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.body)
            .foregroundColor(.black)
            .padding()
            .background(Color.white)
    }
}
