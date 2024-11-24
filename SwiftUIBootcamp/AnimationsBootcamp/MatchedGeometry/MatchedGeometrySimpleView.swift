//
//  MatchedGeometrySimpleView.swift
//  SwiftUIBootcamp
//
//  Created by Max Ward on 05/10/2023.
//

import SwiftUI

struct MatchedGeometrySimpleView: View {
    @Namespace private var namespace
    @State private var animate: Bool = false
    private var matchGeoId: String = "rectangle_animation"
    private var frame: Double {
        animate ? 90 : 200
    }
    
    var body: some View {
        BaseViewBackground(background: Color.gray.opacity(0.3)) {
            VStack {
                Circle()
                    .fill(.red)
                    .frame(width: frame, height: frame)
                    .matchedGeometryEffect(id: "rectangle_animation", in: namespace)
            }
            .debugViewLimit()
            .onTapGesture {
                withAnimation(Animation.easeInOut(duration: 0.9)) {
                    animate.toggle()
                }
            }
        }
    }
}

#Preview {
    MatchedGeometrySimpleView()
}
