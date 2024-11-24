//
//  AnimatedButtonsBootcamp.swift
//  SwiftUIBootcamp
//
//  Created by Max on 19/06/2024.
//

import SwiftUI

struct AnimatedButtonsBootcamp: View {
    var body: some View {
        BaseView {
            VStack {
                Button {
                    print("pressed")
                } label: {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .renderingMode(.original)
                        .frame(width: 60, height: 60)
                }
                .buttonStyle(ScaleButtonStyle())
                
                ButtonFilled(label: "Hi") {
                    print("")
                }
                .buttonStyle(OffsetButtonStyle())
            }
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }
}

struct OffsetButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            //.brightness(configuration.isPressed ? 0.05 : 0)
            .opacity(configuration.isPressed ? 0.9 : 1)
            .offset(x: configuration.isPressed ? -3.0 : 0, y: configuration.isPressed ? 2.0 : 0)
    }
}

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
                .scaleEffect(configuration.isPressed ? 1.2 : 1)
                .brightness(configuration.isPressed ? 0.05 : 0)
    }
}

#Preview {
    NavigationStack{
        AnimatedButtonsBootcamp()
            .navigationTitle("Animated button")
    }
}
