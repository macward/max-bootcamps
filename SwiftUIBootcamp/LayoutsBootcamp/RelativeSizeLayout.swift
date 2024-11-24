//
//  RelativeSizeLayout.swift
//  SwiftUIBootcamp
//
//  Created by Max on 04/06/2024.
//

import SwiftUI

// Article explaining Layout
// https://oleb.net/2023/swiftui-relative-size/

fileprivate struct RelativeSizeLayout: Layout {
    
    var relativeWidth: Double // Ancho relativo en proporción al contenedor
    var relativeHeight: Double // Alto relativo en proporción al contenedor
    
    /// Calcula el tamaño que mejor se ajusta para el subview basado en la propuesta y las dimensiones relativas
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        assert(subviews.count == 1, "expects a single subview") // Asegura que solo haya un subview
        let resizedProposal = ProposedViewSize(
            width: proposal.width.map { $0 * relativeWidth }, // Ajusta el ancho según la proporción
            height: proposal.height.map { $0 * relativeHeight } // Ajusta la altura según la proporción
        )
        return subviews[0].sizeThatFits(resizedProposal) // Devuelve el tamaño ajustado del subview
    }
    
    /// Coloca los subviews dentro de los límites especificados, usando una propuesta ajustada
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        assert(subviews.count == 1, "expects a single subview") // Asegura que solo haya un subview
        let resizedProposal = ProposedViewSize(
            width: proposal.width.map { $0 * relativeWidth }, // Ajusta el ancho según la proporción
            height: proposal.height.map { $0 * relativeHeight } // Ajusta la altura según la proporción
        )
        subviews[0].place(
            at: CGPoint(x: bounds.midX, y: bounds.midY), // Centra el subview en el contenedor
            anchor: .center, // Usa el centro como ancla
            proposal: resizedProposal // Usa la propuesta ajustada para el tamaño
        )
    }
}

extension View {
    /// Modificador de vista para aplicar un tamaño propuesto relativo basado en los parámetros dados
    public func relativeProposed(width: Double = 1, height: Double = 1) -> some View {
        RelativeSizeLayout(relativeWidth: width, relativeHeight: height) { // Crea un layout con proporciones dadas
            VStack {
                self // Aplica el layout a la vista actual
            }
        }
    }
}

struct RelativeFrame: View {
    @State private var multiplier: Double = 0.5 // Estado que controla la altura relativa
    
    var body: some View {
        ZStack {
            Color.clear // Fondo transparente para el ZStack
            GeometryReader(content: { geometry in
                Image("image 1")
                    .resizable() // Hace que la imagen sea redimensionable
                    .relativeProposed(height: multiplier) // Aplica el tamaño relativo en base al multiplicador
            })
        }
        .overlay(alignment: .bottom) {
            Slider(value: $multiplier, in: 0.0...1.0) // Control deslizante para ajustar el multiplicador
                .padding() // Agrega espacio alrededor del slider
        }
    }
}

#Preview {
    RelativeFrame()
}
