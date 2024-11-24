//
//  BackgroundPreferenceBootcamp.swift
//  SwiftUIBootcamp
//
//  Created by Max on 11/04/2024.
//

import SwiftUI

struct BackgroundPreferenceBootcamp: View {
    var body: some View {
        TextWithBackgroundView()
            .backgroundPreferenceValue(SizePreference.self) { value in
                GeometryReader(content: { _ in
                    if let rect = value {
                        Rectangle()
                            .path(in: rect)
                            .stroke(lineWidth: 3)
                            .foregroundStyle(Color.red)
                    }
                })
            }
    }
}

struct TextWithBackgroundView: View {
    var body: some View {
        Text("Texto dinamico, es interesante como funciona siempre y cuando sepamos como todo puede suceder")
            .padding()
            .background(
                GeometryReader(content: { geometry in
                    Color.clear
                        .preference(key: SizePreference.self, 
                                    value: geometry.frame(in: .local))
            }))
    }
}

struct SizePreference: PreferenceKey {
    
    typealias Value = CGRect?
    static var defaultValue: Value? = nil
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}

#Preview {
    BackgroundPreferenceBootcamp()
}
