//
//  RelativeFrameLayout.swift
//  SwiftUIBootcamp
//
//  Created by Max on 03/06/2024.
//

import SwiftUI
/*

 El modificador containerRelativeFrame en SwiftUI se utiliza para ajustar el tamaño de una vista en
 relación con el contenedor en el que se encuentra. Aquí está lo que hace en el contexto del
 código que proporcionaste:

 - containerRelativeFrame(.vertical): Especifica que la vista debe ajustar su tamaño verticalmente (en la dimensión vertical) en relación con el contenedor.

 - { length, axis in ... }: Esta es una clausura que recibe dos parámetros: length, que representa la longitud del contenedor en la dirección especificada (en este caso, vertical), y axis, que es el eje (vertical u horizontal).
 
 - Dentro de la clausura, se define cómo se ajustará la longitud de la vista en relación con el contenedor. En tu código, se usa length * multiplier para ajustar dinámicamente el tamaño del rectángulo en función de un valor de multiplier.
 
 */

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
                .fill(Color.tertiaryBg) // Rellena el rectángulo con el color terciario de fondo
                .ignoresSafeArea() // Ignora las áreas seguras de la pantalla para llenar toda el área
                .containerRelativeFrame(.vertical) { length, axis in
                    withAnimation {
                        // Calcula la longitud relativa del contenedor multiplicándola por el valor de 'multiplier'
                        // y aplica una animación para suavizar el cambio
                        return length * multiplier
                    }
                }

            
            // panel de control
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
                                            withAnimation {
                                                containerAlignment = .top
                                            }
                                        case "center":
                                            withAnimation {
                                                containerAlignment = .center
                                            }
                                        case "bottom":
                                            withAnimation {
                                                containerAlignment = .bottom
                                            }
                                        default: break
                                        }
                                    }
                                }
                            }
                        }
                        VStack(alignment: .leading){
                            Text("Container Height")
                            Slider(value: $multiplier, in: 0.0...1.0)
                                .animation(.easeInOut, value: multiplier)
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
