//
//  CircularLayoutSample.swift
//  SwiftUIBootcamp
//
//  Created by Max on 23/08/2024.
//

import SwiftUI

import SwiftUI

// Definición de un layout personalizado que posiciona las subviews en un círculo
struct CircularLayout: Layout {
    
    /// Calcula el tamaño que mejor se ajusta para el layout, basado en las dimensiones de las subviews
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        // Asume un tamaño cuadrado basado en el menor valor entre ancho y alto propuestos
        let side = min(proposal.width ?? 100, proposal.height ?? 100)
        return CGSize(width: side, height: side)
    }
    
    /// Posiciona las subviews en un círculo dentro de los límites especificados
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        // Calcula el centro y el radio del círculo
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) / 2.5
        
        // Número de subviews
        let count = subviews.count
        
        // Coloca cada subview en una posición circular
        for (index, subview) in subviews.enumerated() {
            let angle = (2 * .pi / Double(count)) * Double(index)
            let xOffset = cos(angle) * radius
            let yOffset = sin(angle) * radius
            let point = CGPoint(x: center.x + xOffset, y: center.y + yOffset)
            
            // Coloca cada subview en su posición calculada
            subview.place(at: point, anchor: .center, proposal: .unspecified)
        }
    }
}

struct CircularLayoutExample: View {
    var body: some View {
        CircularLayout { // Usando el layout personalizado
            ForEach(0..<12) { index in
                Circle()
                    .fill(Color.blue)
                    .frame(width: 50, height: 50)
                    .overlay(Text("\(index + 1)").foregroundColor(.white))
            }
        }
        .frame(width: 300, height: 300)
        .background(Color.gray.opacity(0.2))
        .padding()
    }
}

#Preview {
    CircularLayoutExample()
}
