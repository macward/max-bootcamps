//
//  AIScreenContainerView.swift
//  SwiftUIBootcamp
//
//  Created by Max Ward on 29/09/2023.
//

import SwiftUI

struct AIScreenContainerView: View {
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            ScrollView {
                if #available(iOS 17.0, *) {
                        AIScreenView()
                            .containerRelativeFrame([.horizontal, .vertical])
                } else {
                    Text("old")
                }
            }
        }
    }
}

#Preview {
    AIScreenContainerView()
}
