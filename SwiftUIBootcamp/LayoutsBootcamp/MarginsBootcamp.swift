//
//  MarginsBootcamp.swift
//  SwiftUIBootcamp
//
//  Created by Max on 06/06/2024.
//

import SwiftUI

struct MarginsBootcamp: View {
    var body: some View {
        ZStack {
            Color.green3.ignoresSafeArea()
            
            VStack {
                Text("Elemento 1")
                Text("Elemento 2")
            }
            .contentMargins(20)
            .background(Color.green5)
            .debugViewLimit(.yellow)
        }

    }
}

#Preview {
    MarginsBootcamp()
}
