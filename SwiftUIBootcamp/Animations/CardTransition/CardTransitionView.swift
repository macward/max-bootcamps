//
//  CardTransitionView.swift
//  AnimationsBootcamp
//
//  Created by Max Ward on 26/09/2023.
//

import SwiftUI

struct CardTransitionView: View {
    
    @Namespace var namespace
    @State private var show: Bool = false
    
    var body: some View {
        ZStack {
            if !show {
                VStack {
                    Spacer()
                    VStack (alignment: .leading, spacing: 12) {
                        Text("SwiftUI")
                            .font(.largeTitle.weight(.bold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .matchedGeometryEffect(id: "title", in: namespace)
                        
                        Text("20 sections - 3 hours".uppercased())
                            .font(.footnote.weight(.semibold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .matchedGeometryEffect(id: "subtitle", in: namespace)
                        
                        Text("Build an iOS app for iOS 15 with custom layouts animations and...")
                            .font(.footnote)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .matchedGeometryEffect(id: "text", in: namespace)
                    }
                    .padding(20)
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.ultraThinMaterial)
                            .blur(radius: 30)
                            .matchedGeometryEffect(id: "blur", in: namespace)
                    }
                }
                .foregroundStyle(Color.white)
                .background(
                    Image("Illustration 9")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "image", in: namespace)
                )
                .background(
                    Image("Background 5")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .matchedGeometryEffect(id: "bg", in: namespace)
                )
                .mask({
                    RoundedRectangle(cornerRadius: 20)
                        .matchedGeometryEffect(id: "mask", in: namespace)
                })
                .frame(height: 300)
                .padding(20)
                
            } else {
                ScrollView {
                    VStack {
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(20)
                    .foregroundStyle(Color.black)
                    .background(
                        Image("Illustration 9")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .matchedGeometryEffect(id: "image", in: namespace)
                    )
                    .background(
                        Image("Background 5")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .matchedGeometryEffect(id: "bg", in: namespace)
                    )
                    .mask(
                        RoundedRectangle(cornerRadius: 20)
                            .matchedGeometryEffect(id: "mask", in: namespace)
                    )
                    .overlay {
                        VStack (alignment: .leading, spacing: 12) {
                            Text("Build an iOS app for iOS 15 with custom layouts animations and...")
                                .font(.footnote)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .matchedGeometryEffect(id: "text", in: namespace)
                            
                            Text("20 sections - 3 hours".uppercased())
                                .font(.footnote.weight(.semibold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .matchedGeometryEffect(id: "subtitle", in: namespace)
                            
                            Text("SwiftUI")
                                .font(.largeTitle.weight(.bold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .matchedGeometryEffect(id: "title", in: namespace)
                            Divider()
                            HStack {
                                Image("Avatar Default")
                                    .resizable()
                                    .frame(width: 26, height: 26)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .padding(8)
                                    .background(
                                        RoundedRectangle(cornerRadius: 18)
                                            .fill(.ultraThinMaterial)
                                    )
                                Text("Thought by Max Ward")
                                    .font(.footnote)
                            }
                        }
                        .padding(20)
                        .background {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.ultraThinMaterial)
                                .matchedGeometryEffect(id: "blur", in: namespace)
                        }
                        .offset(y: 200)
                        .padding(20)
                    }
                    .frame(height: 500)
                    .padding(20)
                }
                .ignoresSafeArea()
            }
        }
        .onTapGesture {
            withAnimation (.spring(response: 0.6, dampingFraction: 0.8)) {
                show.toggle()
            }
        }
    }
}

#Preview {
    CardTransitionView()
}
