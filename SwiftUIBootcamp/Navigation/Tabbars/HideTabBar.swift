//
//  HideTabBar.swift
//  SwiftUIBootcamp
//
//  Created by Max Ward on 29/09/2023.
//

import SwiftUI

struct HashableObject: Hashable {
    var name: String
}

struct HideTabBar: View {
    
    @State private var tabState: Visibility = .visible
    
    var body: some View {
        TabView {
            NavigationStack {
                ScrollView {
                    VStack (spacing: 12) {
                        ForEach(0..<10, id: \.self) { index in
                            GeometryReader(content: { proxy in
                                let size = proxy.size
                                NavigationLink(value: HashableObject(name: "Sample")) {
                                    Image("image \(index + 1)")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: size.width, height: size.height)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                }
                            })
                            .frame(height: 180)
                            .padding(.horizontal)
                        }
                    }
                    .onAppear() {
                        tabState = .visible
                    }
                    .navigationDestination(for: HashableObject.self) { obj in
                        AIScreenContainerView()
                            .onAppear() {
                                tabState = .hidden
                            }
                    }
                }
                .navigationTitle("Home")
            }
            .toolbar(tabState, for: .tabBar)
            .animation(.easeInOut(duration: 0.3), value: tabState)
            .tabItem {
                Label("Home", systemImage: "house")
            }
            
            Text("Favourites")
            .tabItem {
                Label("Favourites", systemImage: "heart.fill")
            }
            
            Text("Notifications")
                .badge("2")
                .tabItem {
                    Label("Notifications", systemImage: "bell")
                }
            
            Text("View 3")
                .tabItem {
                    Label("Account", systemImage: "person")
                }
        }
    }
}

#Preview {
    HideTabBar()
}
