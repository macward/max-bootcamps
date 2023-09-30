//
//  ScrollTestView.swift
//  SwiftUIBootcamp
//
//  Created by Max Ward on 29/09/2023.
//

import SwiftUI

struct ColorObject: Hashable {
    var color: Color
}

struct ColorObjects {
    static func list() -> [ColorObject] {
        return [
            ColorObject(color: .blue1),
            ColorObject(color: .blue2),
            ColorObject(color: .blue3),
            ColorObject(color: .blue4),
            ColorObject(color: .blue1),
            ColorObject(color: .green1),
            ColorObject(color: .green2),
            ColorObject(color: .green3),
            ColorObject(color: .green4),
            ColorObject(color: .green5),
        ]
    }
}

struct ScrollTestView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    private var colors: [ColorObject] = ColorObjects.list()
    var body: some View {
        if #available(iOS 17, *) {
            ScrollView (.horizontal, showsIndicators: false) {
                HStack {
                    ForEach (colors, id: \.self) { item in
                        Circle()
                            .containerRelativeFrame(.horizontal,
                                                    count: verticalSizeClass == .regular ? 3 : 4,
                                                    spacing: 16)
                            .foregroundStyle(item.color.gradient)
                            .scrollTransition { content, phase in
                                content
                                    .opacity(phase.isIdentity ? 1.0 : 0.0)
                                    .scaleEffect(x: phase.isIdentity ? 1.0 : 0.3,
                                                 y: phase.isIdentity ? 1.0 : 0.3)
                                    .offset(y: phase.isIdentity ? 0 : 50)
                                                 
                                
                            }
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
