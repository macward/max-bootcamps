//
//  PaddingBootcamp.swift
//  SwiftUIBootcamp
//
//  Created by Max on 06/06/2024.
//

import SwiftUI

struct PaddingBootcamp: View {
    var body: some View {
        ZStack(alignment: .top) {
            Color.green3.ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: true) {
                ForEach(0...50, id: \.self) { _ in
                    SocialMediaCardView()
                }
            }
            .navigationTitle("Feed")
        }
        .safeAreaPadding(.vertical, 44)
        // como se agrego este safeAreaPadding al zstack, toda la pantalla tiene
        // un padding de 16. Solo es ignorado por le color de fondo que implicitamente
        // se le pide que ignore el safe area padding.
    }
}

#Preview {
    PaddingBootcamp()
}
