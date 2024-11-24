//
//  KeyframeAnimationBootcamp.swift
//  SwiftUIBootcamp
//
//  Created by Max on 23/06/2024.
//

import SwiftUI

struct KeyframeAnimationBootcamp: View {
    var body: some View {
        BaseView {
            ReactionView()
                .keyframeAnimator(initialValue: AnimationValues()) { content, value in
                    content
                        .rotationEffect(value.angle)
                        .scaleEffect(value.scale)
                        .scaleEffect(y: value.verticalStretch)
                        .offset(y: value.verticalTranslation)
                } keyframes: { _ in
                    
                    /*
                     aqui se iran agregando tracks de keyframe.
                     cada track representa una propiedad que sera animada.
                     Dentro de cada track podremos ir agregando la cantidad
                     de keyframes que queremos.
                     existen 4 tipos de keyframes:
                        - LinearKeyframe
                        - SpringKeyframe
                        - CubicKeyframe
                        - MoveKeyframe
                     */
                    
                    KeyframeTrack(\.scale) {
                        LinearKeyframe(1.0, duration: 0.35)
                        SpringKeyframe(2, duration: 0.8, spring: .bouncy)
                        SpringKeyframe(1.0, duration: 0.2, spring: .smooth)
                        SpringKeyframe(1.0, duration: 0.0, spring: .smooth)
                    }
                    
                    KeyframeTrack(\.verticalTranslation) {
                        LinearKeyframe(0.0, duration: 0.1)
                        SpringKeyframe(60.0, duration: 0.15, spring: .bouncy)
                        SpringKeyframe(-60.0, duration: 1.0, spring: .bouncy)
                        SpringKeyframe(0.0, spring: .bouncy)
                    }
                }

        }
    }
}

struct AnimationValues {
    var scale = 1.0
    var verticalStretch = 1.0
    var verticalTranslation = 0.0
    var angle = Angle.zero
}

struct ReactionView: View {
    var body: some View {
        Text("🥹")
            .font(.title)
    }
}

#Preview {
    KeyframeAnimationBootcamp()
}
