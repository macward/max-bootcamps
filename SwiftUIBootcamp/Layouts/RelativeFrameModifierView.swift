//
//  RelativeFrameModifierView.swift
//  SwiftUIBootcamp
//
//  Created by Max Ward on 29/09/2023.
//

import SwiftUI

struct RelativeFrameModifierView: View {
    var body: some View {
        if #available(iOS 17, *) {
            ScrollView {
                VStack {
                    Rectangle().fill(Color.blue)
                        .containerRelativeFrame([.vertical]) //
                    
                    Rectangle().fill(Color.red)
                        .containerRelativeFrame([.vertical])
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.paging)
            .ignoresSafeArea(edges: .all)
        } else {
            Text("")
        }
    }
}

#Preview {
    RelativeFrameModifierView()
}
