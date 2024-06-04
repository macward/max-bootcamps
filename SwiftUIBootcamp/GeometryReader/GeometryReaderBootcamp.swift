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

struct NoGeometryReaderBootcamp: View {
    var body: some View {
        VStack {
            HStack {
                Text("Text line 1")
            }
            
            HStack {
                Text("Text line 2")
                Text("Text line 3")
            }
        }
        .debugOverlay("", color: .red, alignment:.center, offset: 0)
        .foregroundStyle(Color.white)
        .background(Color.green1)
    }
}

#Preview {
    GeometryReaderBootcamp()
        .debugLayout(true)
}

#Preview(body: {
    NoGeometryReaderBootcamp()
        .debugLayout(true)
})
