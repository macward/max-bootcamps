//
//  ButtonsComponentBootcam.swift
//  SwiftUIBootcamp
//
//  Created by Max on 31/05/2024.
//

import Foundation
import SwiftUI

let BUTTON_HEIGHT: CGFloat = 38

public struct ButtonFilled: View {
    
    private var label: String
    private var action: () -> Void
        
    public init(label: String, _ action: @escaping () -> Void) {
        self.label = label
        self.action = action
    }
    
    public var body: some View {
        Button{
            action()
        } label: {
            Text(label)
                .foregroundColor(.white)
                .font(.body)
                .padding(.horizontal)
                .frame(minHeight: BUTTON_HEIGHT)
                .background(.darkBlue100)
                .cornerRadius(.small)
        }
        .buttonStyle(.plain)
    }
}

public struct ButtonBordered: View{
    
    private var label: String
    private var action: () -> Void
    
    public init(label: String, _ action: @escaping () -> Void) {
        self.label = label
        self.action = action
    }
    
    public var body: some View {
        Button{
            action()
        } label: {
            Text(label)
                .font(.body)
                .foregroundStyle(.darkBlue80)
                .padding(.horizontal)
                .frame(minHeight: BUTTON_HEIGHT)
                .cornerRadius(.small)
                .overlay {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.darkBlue80)
                }
        }
        .buttonStyle(.plain)
    }
}

public struct ButtonTextWithImage: View {
    
    private var label: String
    private var icon: String
    private var action: () -> Void
    
    public init(label: String, icon: String, action: @escaping () -> Void) {
        self.label = label
        self.icon = icon
        self.action = action
    }
    
    public var body: some View {
        Button{
            action()
        } label: {
            HStack {
                Image(systemName: icon)
                Text(label)
            }
            .foregroundColor(.white)
            .font(.caption)
            .padding(.horizontal)
            .frame(minHeight: BUTTON_HEIGHT)
            .background(.darkBlue100)
            .cornerRadius(.small)
            
        }
        .buttonStyle(.plain)
    }
}

public struct ButtonWithIcon: View {
    
    private var icon: String
    private var action: () -> Void
    
    public init(icon: String, _ action: @escaping () -> Void) {
        self.icon = icon
        self.action = action
    }
    
    public var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: icon)
                .frame(width: BUTTON_HEIGHT, height: BUTTON_HEIGHT)
                .foregroundColor(.white)
                .background(.darkBlue100)
                .cornerRadius(.small)
        }
        .buttonStyle(.plain)
    }
}

public struct ButtonCircleIcon: View {
    
    private var icon: String
    private var action: () -> Void
    
    public init(icon: String, action: @escaping () -> Void) {
        self.icon = icon
        self.action = action
    }
    
    public var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: icon)
                .frame(width: BUTTON_HEIGHT, height: BUTTON_HEIGHT)
                .foregroundColor(.white)
                .background(.darkBlue100)
                .cornerRadius(BUTTON_HEIGHT / 2)
        }
        .buttonStyle(.plain)
    }
}

public struct ButtonCaptionWithIcon: View {
    
    private var icon: String
    private var caption: String
    private var action: () -> Void
    
    public init(icon: String, caption: String, action: @escaping () -> Void) {
        self.icon = icon
        self.caption = caption
        self.action = action
    }
    
    public var body: some View {
        Button {
            action()
        } label: {
            VStack(spacing: 2) {
                Image(systemName: icon)
                    .frame(width: BUTTON_HEIGHT, height: BUTTON_HEIGHT)
                    .foregroundColor(.white)
                    .background(.darkBlue100)
                    .cornerRadius(.small)
                Text(caption)
                    .foregroundStyle(.darkBlue80)
                    .font(.caption2)
                    .frame(width: 80)
            }
        }
        .buttonStyle(.plain)
    }
}

public struct ButtonToggleIcon: View {
    
    private var icon: String
    private var action: (Bool) -> Void
    @State private var isActive = false
    
    public init(icon: String, action: @escaping (Bool) -> Void, isActive: Bool = false) {
        self.icon = icon
        self.action = action
        self.isActive = isActive
    }
    
    public var body: some View {
        if #available(iOS 17.0, *) {
            Image(systemName: icon)
                .frame(width: BUTTON_HEIGHT, height: BUTTON_HEIGHT)
                .foregroundColor(isActive ? .white : .darkBlue100)
                .background(isActive ? .darkBlue100 : .clear)
                .cornerRadius(.small)
                .overlay {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(.darkBlue100)
                }
                .onTapGesture {
                    withAnimation {
                        isActive.toggle()
                    }
                }
                .onChange(of: isActive) { oldValue, newValue in
                    action(isActive)
                }
                .buttonStyle(.plain)
        } else {
            EmptyView()
        }
    }
}

public struct ButtonModern: View {
    
    private var label: String
    private var icon: String
    private var action: () -> Void
    
    public init(label: String, icon: String, action: @escaping () -> Void) {
        self.label = label
        self.icon = icon
        self.action = action
    }
    
    public var body: some View {
        Button {
            action()
        } label: {
            ZStack(alignment: .leading) {
                Text(label)
                    .foregroundStyle(.darkBlue100)
                    .padding(.all, BUTTON_HEIGHT / 4)
                    .padding(.leading, BUTTON_HEIGHT - 5)
                    .overlay {
                        RoundedRectangle(cornerRadius: BUTTON_HEIGHT)
                            .stroke(.darkBlue100)
                    }
                
                Image(systemName: icon)
                    .frame(width: BUTTON_HEIGHT * 1, height: BUTTON_HEIGHT * 1)
                    .foregroundColor(.white)
                    .background(.darkBlue100)
                    .cornerRadius(BUTTON_HEIGHT)
                    .offset(x: -1)
            }
        }
        .buttonStyle(.plain)
    }
}

struct ButtonsBootcamp: View {
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    ButtonCircleIcon(icon: "house.fill", action: {})
                    Text("Circle button")
                }
                HStack {
                    ButtonWithIcon(icon: "house.fill", {})
                    Text("Button with icon")
                }
                HStack {
                    ButtonToggleIcon(icon: "house.fill") { status in
                        print(status)
                    }
                    
                    ButtonToggleIcon(icon: "house.fill", action: { status in
                        print("status")
                    }, isActive: true)
                    Text("Toggle button")
                }
                HStack {
                    ButtonCaptionWithIcon(icon: "house.fill", caption: "caption sample", action: {})
                    Text("Button caption with icon")
                }
                HStack {
                    ButtonFilled(label: "Filled button", {})
                    Text("Filled button")
                }
                
                HStack {
                    ButtonBordered(label: "Hello", {})
                    Text("Bordered button")
                }
                HStack {
                    ButtonTextWithImage(label: "Text with image", icon: "house.fill", action: {})
                    Spacer()
                    Text("Button text and image")
                }
                HStack {
                    ButtonModern(label: "Modren button", icon: "house.fill", action: {})
                    Text("Modren button")
                }
            }
        }
        .padding()
    }
}

#Preview {
    ButtonsBootcamp()
}

