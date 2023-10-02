//
//  ViewLimit.swift
//  SwiftUIBootcamp
//
//  Created by Max Ward on 02/10/2023.
//

import SwiftUI

struct ViewLimit: ViewModifier {
    
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .border(color)
    }
}

extension View {
    func debugViewLimit(_ color: Color = .green) -> some View {
        modifier(ViewLimit(color: color))
    }
}
