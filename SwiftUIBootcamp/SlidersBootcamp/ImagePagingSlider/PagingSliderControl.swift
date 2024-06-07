//
//  PagingSliderControl.swift
//  SwiftUIBootcamp
//
//  Created by Max on 27/05/2024.
//

import Foundation
import SwiftUI

// Vista principal para el control deslizante de imágenes
struct PagingSliderControl<Content: View, Item: RandomAccessCollection>: View where Item: MutableCollection, Item.Element: Identifiable {
    
    var data: Item // Datos a mostrar en el control deslizante
    @ViewBuilder var content: (Item.Element) -> Content // Contenido de la vista para cada elemento
    @State private var activeID: UUID? // ID del elemento actualmente activo
    
    var body: some View {
        VStack {
            if #available(iOS 17, *) {
                // ScrollView horizontal para el deslizante de imágenes
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(data) { item in
                            VStack {
                                content(item) // Genera la vista para cada elemento
                            }
                            .containerRelativeFrame(.horizontal) // Establece el marco relativo para cada contenedor
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollIndicators(.hidden) // Oculta los indicadores de desplazamiento
                .scrollTargetBehavior(.viewAligned) // Comportamiento de alineación del objetivo de desplazamiento
                .scrollPosition(id: $activeID) // Establece la posición de desplazamiento basada en activeID
                
                // Control de paginación
                PagingControl(numberOfPages: data.count, activePage: activePage) { value in
                    print(value)
                }
            } else {
                // Mensaje para versiones de iOS anteriores a 17
                Text("iOS 17 only")
            }
        }
    }
    
    // Calcula la página activa basada en activeID
    var activePage: Int {
        if let index = data.firstIndex(where: { $0.id as? UUID == activeID }) as? Int {
            return index
        }
        return 0
    }
}

// Representable para UIPageControl de UIKit
struct PagingControl: UIViewRepresentable {
    
    var numberOfPages: Int // Número total de páginas
    var activePage: Int // Página actualmente activa
    var onPageChange: (Int) -> Void // Callback para el cambio de página
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(onPageChange: onPageChange)
    }
    
    func makeUIView(context: Context) -> UIPageControl {
        let view = UIPageControl()
        view.currentPage = activePage
        view.numberOfPages = numberOfPages
        view.backgroundStyle = .prominent
        view.currentPageIndicatorTintColor = UIColor(Color.primary)
        view.pageIndicatorTintColor = UIColor.placeholderText
        view.backgroundColor = .clear // Hacer el fondo transparente
        view.addTarget(context.coordinator, action: #selector(Coordinator.onPageUpdate(control:)), for: .valueChanged)
        return view
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.numberOfPages = numberOfPages
        uiView.currentPage = activePage
    }
    
    class Coordinator: NSObject {
        var onPageChange: (Int) -> Void
        
        init(onPageChange: @escaping (Int) -> Void) {
            self.onPageChange = onPageChange
        }
        
        // Método que se llama cuando cambia la página en el UIPageControl
        @objc
        func onPageUpdate(control: UIPageControl) {
            onPageChange(control.currentPage)
        }
    }
}
