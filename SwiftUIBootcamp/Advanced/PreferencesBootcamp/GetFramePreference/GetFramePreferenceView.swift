//
//  GetFrame.swift
//  SwiftUIBootcamp
//
//  Created by Max on 14/04/2024.
//

import Foundation
import SwiftUI

struct GetFramePreferenceView: View {
    
    @State private var frame: CGRect = .zero
    
    var body: some View {
        Text("Sample text \(frame.width)")
            .frameCapture($frame)
        
        Rectangle()
            .fill(Color.red)
            .frame(width: frame.width, height: 60)
    }
}

struct FrameCapture: ViewModifier {
    @Binding var frame: CGRect
    
    func body(content: Content) -> some View {
        content.background(GeometryReader { geometryProxy in
            Color.clear
                .preference(key: FramePreferenceKey.self, value: geometryProxy.frame(in: .global))
        })
        .onPreferenceChange(FramePreferenceKey.self) { newFrame in
            if newFrame.integral != frame.integral {
                frame = newFrame
            }
        }
    }
}

fileprivate extension View {
    func frameCapture(_ frame: Binding<CGRect>) -> some View {
        modifier(FrameCapture(frame: frame))
    }
}

fileprivate struct FramePreferenceKey: PreferenceKey {
    static var defaultValue: CGRect = .zero

    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}



#Preview {
    GetFramePreferenceView()
}

