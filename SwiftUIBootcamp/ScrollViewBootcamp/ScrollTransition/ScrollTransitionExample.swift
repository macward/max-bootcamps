//
//  ScrollTransitionExample.swift
//  SwiftUIBootcamp
//
//  Created by Max on 04/06/2024.
//

import SwiftUI

struct ScrollTransitionExample1: View {
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(0..<20) { index in
                    SocialMediaCardView()
                        .containerRelativeFrame(.horizontal)
                        .scrollTransition(topLeading: .interactive, bottomTrailing: .interactive) { content, phase in
                            switch phase {
                            case .topLeading:
                                content
                                    .scaleEffect(0.8)
                                    .opacity(0.5)
                                    .rotationEffect(.degrees(-15))
                            case .identity:
                                content
                                    .scaleEffect(1.0)
                                    .opacity(1.0)
                                    .rotationEffect(.degrees(0))
                            case .bottomTrailing:
                                content
                                    .scaleEffect(0.8)
                                    .opacity(0.5)
                                    .rotationEffect(.degrees(15))
                            }
                        }
                }
            }
            .scrollTargetLayout()
        }
        .scrollIndicators(.hidden)
        .contentMargins(18, for: .scrollContent)
        .scrollTargetBehavior(.viewAligned)
    }
}

#Preview {
    ScrollTransitionExample1()
}
