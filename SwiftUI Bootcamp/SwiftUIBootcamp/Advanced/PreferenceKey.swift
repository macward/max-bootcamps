//
//  PreferenceKey.swift
//  SwiftUIBootcamp
//
//  Created by Max Ward on 07/10/2023.
//

import SwiftUI

struct ComponentTitlePreferenceKey: PreferenceKey {
    static var defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

struct ComponentTitleViewModifier: ViewModifier {
    var title: String
    
    func body(content: Content) -> some View {
        content
            .preference(key: ComponentTitlePreferenceKey.self, value: title)
    }
}

extension View {
    func componentTitle(title: String) -> some View {
        modifier(ComponentTitleViewModifier(title: title))
    }
}


struct PreferenceKeySampleView: View {
    
    @State private var title: String = ""
    
    var body: some View {
        CustomNavView {
            Text("Hello, World!")
                .componentTitle(title: "Title from PreferenceKey")
        }
    }
}

struct CustomNavView<Content: View>: View {
    
    @State var title: String = ""
    @ViewBuilder var content: Content
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .bold()
            GeometryReader { _ in
                ScrollView {
                    content
                }
            }
        }
        .padding(.horizontal)
        .onPreferenceChange(ComponentTitlePreferenceKey.self) { value in
            title = value
        }
    }
}
#Preview {
    PreferenceKeySampleView()
}

