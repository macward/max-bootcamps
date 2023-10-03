//
//  RelativeFrameModifierView.swift
//  SwiftUIBootcamp
//
//  Created by Max Ward on 29/09/2023.
//

import SwiftUI


struct RelativeFrameLayout: View {
    
    @State private var multiplier: Double = 0.5
    
    var body: some View {
        if #available(iOS 17, *) {
            VStack {
                Rectangle()
                    .fill(Color.blue.gradient)
                    .containerRelativeFrame(.vertical) { lenght, axis in
                        return lenght * multiplier
                    }
            }
            .debugViewLimit(.green)
            .overlay(alignment: .bottom) {
                Spacer()
                Slider(value: $multiplier, in: 0.0...1.0)
                    .padding()
            }
        } else {
            OnlyiOS17View()
        }
        
    }
}

struct RelativeFrameScroll: View {
    @State private var count: Double = 2.0
    
    var body: some View {
        if #available(iOS 17, *) {
            VStack {
                HStack {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(0...10, id: \.self) { _ in
                                SocialMediaCardView()
                                    .containerRelativeFrame(.horizontal, count: 2, spacing: 8) // este modifier dice que se presentara solo 1 card por pantalla segun el parametro count
                                    .scrollTargetLayout()
                            }
                        }
                    }
                    .scrollTargetBehavior(.paging) // le decimos al scroll que se comporte como un paginador
                    .safeAreaPadding(16) // esto es impotante para centrar la vista
                }
                
                
            }
            
            Spacer()
        }
    }
}


#Preview {
    RelativeFrameLayout()
}

#Preview {
    RelativeFrameScroll()
}
