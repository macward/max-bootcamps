//
//  BaseView.swift
//  SwiftUIBootcamp
//
//  Created by Max Ward on 01/10/2023.
//

import SwiftUI

struct BaseViewBackground<Background: View, Content: View>: View {

    var background: Background
    var content: Content

    init(background: Background,
         @ViewBuilder content: () -> Content)
    {
        self.background = background
        self.content = content()
    }
    var body: some View {
        ZStack {
            background.ignoresSafeArea()
            content
        }
    }
}

struct BaseView<Content: View>: View {
    var content: Content
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            GeometryReader(content: { geometry in
                Image("blueprint1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, alignment: .center)
                    .ignoresSafeArea()
            })
            content
        }
    }
}

struct BaseViewTest: View {
    var body: some View {
        BaseView {
            VStack {
                Text("hi")
                Text("hello")
            }
        }
    }
}

#Preview {
    BaseViewTest()
}
