//
//  SimpleContainerRelativeFrame.swift
//  SwiftUIBootcamp
//
//  Created by Max on 04/06/2024.
//

import Foundation
import SwiftUI

struct SimpleContainerRelativeFrame: View {
    
    @Environment(\.debugLayout) private var debugLayout: Bool

    @State private var count: Double = 1.0
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10.0) {
                ForEach(0...10, id: \.self) { _ in
                    Image("image 5")
                        .resizable()
                        .aspectRatio(3.0 / 2.0, contentMode: .fit)
                        .containerRelativeFrame(.horizontal, count: Int(count), spacing: 8)
                }
            }
        }
        .scrollTargetBehavior(.paging)
        .safeAreaPadding(.horizontal, 20.0)
        .overlay(alignment: .bottom) {
            Stepper("Count: \(count.formatted())",
                    value: $count,
                    in: 1...10,
                    step: 1,
                    onEditingChanged: { _ in
                
            })
            .padding(.horizontal)
            .offset(y: 61)
        }
    }
}


#Preview {
    SimpleContainerRelativeFrame()
}
