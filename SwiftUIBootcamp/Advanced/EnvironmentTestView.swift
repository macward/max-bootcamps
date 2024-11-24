//
//  EnvironmentTestView.swift
//  SwiftUIBootcamp
//
//  Created by Max Ward on 08/10/2023.
//

import SwiftUI

struct EnvironmentTestView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        Text("Environment")
    }
}

#Preview {
    EnvironmentTestView()
}


struct BodyFont: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.body)
            .foregroundColor(.black)
            .padding()
            .background(Color.white)
    }
}
