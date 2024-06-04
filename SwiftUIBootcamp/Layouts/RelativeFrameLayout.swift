//
//  RelativeFrameLayout.swift
//  SwiftUIBootcamp
//
//  Created by Max on 03/06/2024.
//

import SwiftUI

struct RelativeFrameLayout: View {
    
    // este multipler manera el tamaño del frame
    @State private var multiplier: Double = 0.5
    
    // MARK: Buttons
    @State private var selectedButton: ConfigurableButton<String>? = nil
    let buttons = [
        ConfigurableButton(label: "Top", value: "top"),
        ConfigurableButton(label: "Center", value: "center"),
        ConfigurableButton(label: "Button", value: "bottom")
    ]
    // se encarga de manejar la alinacion del frame
    @State private var containerAlignment: Alignment = .top
    
    var body: some View {
        
        ZStack(alignment: containerAlignment){
            Rectangle()
                .fill(Color.tertiaryBg)
                .ignoresSafeArea()
                .containerRelativeFrame(.vertical) { lenght, axis in
                    withAnimation {
                        return lenght * multiplier
                    }
                    
                }
            Color.clear.ignoresSafeArea()
                .overlay(alignment: .bottom) {
                    
                    VStack(alignment: .leading){
                        VStack(alignment: .leading){
                            Text("Alignment")
                            HStack {
                                ForEach(buttons) { button in
                                    ComboButton(button: button, selected: $selectedButton) { value in
                                        switch value {
                                        case "top":
                                            containerAlignment = .top
                                        case "center":
                                            containerAlignment = .center
                                        case "bottom":
                                            containerAlignment = .bottom
                                        default: break
                                        }
                                    }
                                }
                            }
                        }
                        VStack(alignment: .leading){
                            Text("Container Height")
                            Slider(value: $multiplier, in: 0.0...1.0)
                        }
                    }
                    .padding()
                }
        }
        .onAppear() {
            self.selectedButton = buttons.first
        }
    }
}

#Preview {
    RelativeFrameLayout()
}
