//
//  GeometryReaderBootcamp.swift
//  SwiftUIBootcamp
//
//  Created by Max on 04/06/2024.
//

import SwiftUI

struct GeometryReaderBootcamp: View {
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Text("Width: \(proxy.size.width)")
                    .background(Color.primaryAccent)
                    .padding()
                Text("Height: \(proxy.size.height)")
                    .background(Color.primaryAccent)
                    .padding()
                Text("Coordinates Local: \(proxy.frame(in: .local).debugDescription)")
                    .background(Color.primaryAccent)
                    .padding()
                Text("Coordinates Global: \(proxy.frame(in: .global).debugDescription)")
                    .background(Color.primaryAccent)
                    .padding()
            }
        }
        .foregroundStyle(Color.white)
        .background(Color.tertiaryBg)
        .frame(width: 300, height: 300)
    }
}

struct GeometryReaderEffect: View {
    var body: some View {
        ScrollView {
            VStack {
                ForEach(0..<50) { index in
                    GeometryReader { geometry in
                        Text("Row \(index)")
                            .background(
                                Color.red.opacity(Double(geometry.frame(in: .global).minY) / 1000.0)
                            )
                    }
                    .frame(height: 50)
                }
            }
        }
    }
}


#Preview {
    GeometryReaderBootcamp()
        .debugLayout(true)
}

#Preview(body: {
    GeometryReaderEffect()
})

