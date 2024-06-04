//
//  ToggleButton.swift
//  SwiftUIBootcamp
//
//  Created by Max on 04/06/2024.
//

import SwiftUI

public struct ConfigurableButton<T>: Identifiable {
    public let id = UUID()
    public let label: String
    public let value: T

    public init(label: String, value: T) {
        self.label = label
        self.value = value
    }
}

struct ComboButton<T>: View {
    
    private var button: ConfigurableButton<T>
    @Binding var selected: ConfigurableButton<T>?
    private var action: (T) -> Void
    
    var isActive: Bool {
        guard let selected = selected else { return false}
        return button.id == selected.id
    }
    
    init(button: ConfigurableButton<T>, selected: Binding<ConfigurableButton<T>?>, action: @escaping (T) -> Void) {
        self.button = button
        self._selected = selected
        self.action = action
    }
    
    var body: some View {
        Text(button.label)
            .font(.body)
            .foregroundStyle(isActive ? .primaryText : .secondayText)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(isActive ? .primaryBg : .secondaryBg)
            .clipShape(RoundedRectangle(cornerRadius: .spacingMd))
            .overlay(
                RoundedRectangle(cornerRadius: .spacingMd)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .onTapGesture {
                withAnimation {
                    self.selected = self.button
                }
                action(button.value)
            }
    }
}

struct ToggleButtonPreview: View {
    
    let buttons = [
        ConfigurableButton(label: "Button 1", value: 1),
        ConfigurableButton(label: "Button 2", value: 2),
        ConfigurableButton(label: "Button 3", value: 3)
    ]
    
    @State private var selectedButton: ConfigurableButton<Int>? = nil

    var body: some View {
        VStack {
            ForEach(buttons) { button in
                ComboButton(button: button, selected: $selectedButton) { value in
                    print(value)
                }
            }
        }
    }
}

#Preview {
    ToggleButtonPreview()
}
