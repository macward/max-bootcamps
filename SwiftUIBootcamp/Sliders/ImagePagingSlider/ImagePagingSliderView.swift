//
//  ImagePagingSlider.swift
//  SwiftUIBootcamp
//
//  Created by Max on 27/05/2024.
//

import SwiftUI
import UIKit


struct ImagePagingSlider: View {
    @State private var images: [ImageObject] = [
        .init(image: "image 3"),
        .init(image: "image 4"),
        .init(image: "image 5"),
        .init(image: "image 6")
        ]
    
    var body: some View {
        PagingSliderControl(data: images) { item in
            Image(item.image)
                .resizable()
                .scaledToFill()
                .frame(height: 160)
                .clipped()
            
        }
    }
}


#Preview {
    ImagePagingSlider()
}
