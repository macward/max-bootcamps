//
//  CardScrollView.swift
//  SwiftUIBootcamp
//
//  Created by Max Ward on 30/09/2023.
//

import SwiftUI

struct CardScrollView: View {
    
    enum RotationAxis: String, CaseIterable, Identifiable {
        case x, y, z
        var id: Self { self }
    }
    
    @State private var rotationIndex: RotationAxis = .y
    @State private var rotationOffset: CGFloat = 0
    @State private var offset: CGFloat = 0
    @State private var scaleValue: CGFloat = 0.8
    @State private var opacity: CGFloat = 0.5
    @State private var rotationSet: (x: CGFloat, y: CGFloat, z: CGFloat) = (x: 0, y: 1, z: 0)
    
    @State private var showSettings: Bool = false
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .ignoresSafeArea()
                if #available(iOS 17, *) {
                    ScrollView (.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(0...10, id: \.self) { _ in
                                SocialMediaCardView()
                                    .containerRelativeFrame([.horizontal, .vertical])
                                    .scrollTransition { content, phase in
                                        content
                                            .rotation3DEffect(.degrees(phase.value * rotationOffset), axis: rotationSet)
                                            .scaleEffect(x: phase.isIdentity ? 1 : scaleValue,
                                                         y: phase.isIdentity ? 1 : scaleValue)
                                            .opacity(phase.isIdentity ? 1.0 : opacity)
                                            .offset(y: phase.isIdentity ? 0 : offset)
                                                         
                                        
                                    }
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .contentMargins(16, for: .scrollContent)
                    .scrollTargetBehavior(.paging)
                    .toolbar(content: {
                        ToolbarItem {
                            Button {
                                showSettings.toggle()
                            } label: {
                                Image(systemName: "gear")
                                    .foregroundStyle(Color.white)
                            }

                            
                        }
                    })
                    .sheet(isPresented: $showSettings, content: {
                        NavigationStack {
                            ZStack {
                                Color("RBL3BG").ignoresSafeArea()
                                List {
                                    // Offset
                                    VStack (alignment: .leading) {
                                        HStack {
                                            Text("Offset Y")
                                            Spacer()
                                            Text(String(format: "%.2f", offset))
                                        }
                                        
                                        HStack {
                                            Text("-100")
                                            Slider(value: $offset, in: -100...100)
                                            Text("100")
                                        }
                                    }
                                    
                                    Picker("Rotation Axis", selection: $rotationIndex) {
                                        Text("X").tag(RotationAxis.x)
                                        Text("Y").tag(RotationAxis.y)
                                        Text("Z").tag(RotationAxis.z)
                                    }
                                    
                                    VStack (alignment: .leading) {
                                        HStack {
                                            Text("Rotation degrees offset")
                                            Spacer()
                                            Text(String(format: "%.2f", rotationOffset))
                                        }
                                        
                                        HStack {
                                            Text("-100")
                                            Slider(value: $rotationOffset, in: -100...100)
                                            Text("100")
                                        }
                                    }

                                    VStack (alignment: .leading) {
                                        HStack {
                                            Text("Scale value")
                                            Spacer()
                                            Text(String(format: "%.2f", scaleValue))
                                        }
                                        
                                        HStack {
                                            Text("0")
                                            Slider(value: $scaleValue)
                                            Text("1")
                                        }
                                    }
                                    
                                    VStack (alignment: .leading) {
                                        HStack {
                                            Text("Opacity")
                                            Spacer()
                                            Text(String(format: "%.2f", opacity))
                                        }
                                        
                                        HStack {
                                            Text("0")
                                            Slider(value: $opacity)
                                            Text("1")
                                        }
                                    }
                                                                        
                                }
                                
                            }
                            .toolbarTitleDisplayMode(.inline)
                        }
                        .presentationDetents([.fraction(0.65)])
                        .presentationDragIndicator(.hidden)
                    })
                    .onChange(of: rotationIndex) { oldValue, newValue in
                        switch newValue {
                        case .x: self.rotationSet = (x: 1, y: 0, z: 0)
                        case .y: self.rotationSet = (x: 0, y: 1, z: 0)
                        case .z: self.rotationSet = (x: 0, y: 0, z: 1)
                        }
                    }
                } else {
                    EmptyView()
                }
                
            }
        }
    }
}

#Preview {
    CardScrollView()
}
