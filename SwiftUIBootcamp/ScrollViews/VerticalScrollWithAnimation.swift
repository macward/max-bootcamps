//
//  VerticalScrollWithAnimation.swift
//  SwiftUIBootcamp
//
//  Created by Max Ward on 30/09/2023.
//

import SwiftUI

struct VerticalScrollWithAnimation: View {
    var body: some View {
        if #available(iOS 17, *) {
            NavigationStack {
                ScrollView(.vertical) {
                    ForEach(0...50, id: \.self) { _ in
                        SocialMediaCardView()
                            .padding(.horizontal)
                            .scrollTransition(
                                topLeading: .interactive,
                                bottomTrailing: .identity,
                                transition: { content, phase in
                                content
                                        .rotation3DEffect(.degrees(phase.value * -70), axis: (x:1, y: 0, z: 0))
                                        .scaleEffect(x: phase.isIdentity ? 1.0 : 0.5,
                                                 y: phase.isIdentity ? 1.0 : 0.3)
                                        .offset(y: phase.isIdentity ? 0 : 60)
                                        .opacity(phase.isIdentity ? 1 : 0.3)
                            })
                    }
                }
                .navigationTitle("Feed")
            }
        } else {
            EmptyView()
        }
    }
}

#Preview {
    VerticalScrollWithAnimation()
}
