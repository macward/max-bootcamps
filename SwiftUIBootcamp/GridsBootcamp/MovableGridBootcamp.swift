//
//  MovableGridBootcamp.swift
//  SwiftUIBootcamp
//
//  Created by Max on 08/06/2024.
//

import SwiftUI

struct MovableGridBootcamp: View {
    
    @State private var colors: [Color] = ColorObject.colors
    @State private var draggingItem: Color?
    
    var body: some View {
        BaseView {
            ScrollView(.vertical, showsIndicators: false) {
                let columns = Array(repeating: GridItem(spacing: 20), count: 3)
                
                LazyVGrid(columns: columns, content: {
                    ForEach (colors, id: \.self) { color in
                        GeometryReader {
                            let size = $0.size
                            RoundedRectangle(cornerRadius: 10)
                                .fill(color.gradient)
                                .draggable(color) {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(.ultraThinMaterial)
                                        .frame(width: size.width, height: size.height)
                                        .onAppear {
                                            draggingItem = color
                                        }
                                }
                                .dropDestination(for: Color.self) { color, location in
                                    self.draggingItem = nil
                                    return false
                                } isTargeted: { status in
                                    if let draggingItem, status, draggingItem != color {
                                        if let sourceIndex = colors.firstIndex(of: draggingItem), 
                                            let destinationIndex = colors.firstIndex(of: color) {
                                            withAnimation {
                                                let sourceItem = colors.remove(at: sourceIndex)
                                                colors.insert(sourceItem, at: destinationIndex)
                                            }
                                        }
                                    }
                                }
                        }
                        .frame(height: 100)
                    }
                })
                .padding(15)
            }
            .navigationTitle("Movable grid")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NavigationStack {
        MovableGridBootcamp()
            .navigationTitle("Movable grid")
            .navigationBarTitleDisplayMode(.inline)
    }
    
}
