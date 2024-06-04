//
//  BaseView.swift
//  SwiftUIBootcamp
//
//  Created by Max Ward on 01/10/2023.
//

import SwiftUI

struct BaseViewBackground<Background: View, Content: View>: View {
    
    @ViewBuilder var background: Background
    @ViewBuilder var content: Content
    
    var body: some View {
        ZStack(content: {
            background.ignoresSafeArea()
            content
        })
    }
}

struct BaseView<Content: View>: View {
    
    @ViewBuilder var content: Content
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            content
        }
    }
}

struct BaseViewTest: View {
    var body: some View {
        OnlyiOS17View()
    }
}

#Preview {
    BaseViewTest()
}
