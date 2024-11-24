//
//  ViewBuilderDemo.swift
//  SwiftUIBootcamp
//
//  Created by Max on 18/06/2024.
//

import SwiftUI

// Codigo 1: GOOD
struct ViewBuilderDemo<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack {
            content
        }
    }
}
// Codigo 2: BAD
struct ViewBuilderDemo2<Content: View>: View {
    @ViewBuilder let content: Content
    
    var body: some View {
        VStack {
            content
        }
    }
}

#Preview {
    ViewBuilderDemo {
        Text("Inside Custom Container")
        Button("Tap me") {
            print("Button tapped")
        }
    }
}

#Preview {
    ViewBuilderDemo2 {
        Text("Inside Custom Container")
        Button("Tap me") {
            print("Button tapped")
        }
    }
}
