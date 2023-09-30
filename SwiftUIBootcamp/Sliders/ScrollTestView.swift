//
//  ScrollTestView.swift
//  SwiftUIBootcamp
//
//  Created by Max Ward on 29/09/2023.
//

import SwiftUI

struct ScrollTestView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    private var colors: [ColorObject] = ColorObjects.list()
    var body: some View {
        if #available(iOS 17, *) {
            ScrollView (.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach (colors, id: \.self) { item in
                        Circle()
//                            .containerRelativeFrame(.horizontal,
//                                                    count: verticalSizeClass == .regular ? 4 : 4,
//                                                    spacing: 16)
//                            .containerRelativeFrame(.horizontal,
//                                                    count: 3, spacing: 16)
                            .containerRelativeFrame([.horizontal, .vertical])
                            .foregroundStyle(item.color.gradient)
                            .scrollTransition(topLeading: .identity, bottomTrailing: .interactive, transition: { content, phase in
                                content
                                    .opacity(phase.isIdentity ? 1.0 : 0.0)
                                    .scaleEffect(x: phase.isIdentity ? 1.0 : 0.3,
                                                 y: phase.isIdentity ? 1.0 : 0.3)
                                    .offset(y: phase.isIdentity ? 0 : 50)
                            })
//                            .scrollTransition { content, phase in
//                                content
//                                    .opacity(phase.isIdentity ? 1.0 : 0.0)
//                                    .scaleEffect(x: phase.isIdentity ? 1.0 : 0.3,
//                                                 y: phase.isIdentity ? 1.0 : 0.3)
//                                    .offset(y: phase.isIdentity ? 0 : 50)
//                                                 
//                                
//                            }
                    }
                }
                .scrollTargetLayout()
            }
            .contentMargins(16, for: .scrollContent)
            .scrollTargetBehavior(.paging)
        } else {
            EmptyView()
        }
        
    }
}

#Preview {
    ScrollTestView()
}
