//
//  HideSearchBarOnScroll.swift
//  SwiftUIBootcamp
//
//  Created by Max on 05/06/2024.
//

import SwiftUI

struct HideSearchBarOnScroll: View {
    @State private var searchText: String = ""
    
    var body: some View {
        ZStack {
            Color.green1.ignoresSafeArea()
            
            SearchStateScrollView {
                VStack {
                    ForEach(0..<20) { index in
                        SocialMediaCardView()
                            .padding(.horizontal)
                    }
                }
                .navigationTitle("Hide search bar")
                .navigationBarTitleDisplayMode(.inline)
            } searchBar: {
                Rectangle()
                    .frame(height: 80)
                    .padding(.horizontal)
            }
            
        }
    }
}

// Ejemplo de uso con un modelo de datos simple
struct ItemModel: Identifiable {
    let id = UUID()
    let name: String
}

struct ListContentView: View {
    
    let items = [
            ItemModel(name: "Item 1"),
            ItemModel(name: "Item 2"),
            ItemModel(name: "Item 3"),
            ItemModel(name: "Item 4"),
            ItemModel(name: "Item 5"),
            ItemModel(name: "Item 1"),
            ItemModel(name: "Item 2"),
            ItemModel(name: "Item 3"),
            ItemModel(name: "Item 4"),
            ItemModel(name: "Item 5"),
            ItemModel(name: "Item 1"),
            ItemModel(name: "Item 2"),
            ItemModel(name: "Item 3"),
            ItemModel(name: "Item 4"),
            ItemModel(name: "Item 5"),
            ItemModel(name: "Item 1"),
            ItemModel(name: "Item 2"),
            ItemModel(name: "Item 3"),
            ItemModel(name: "Item 4"),
            ItemModel(name: "Item 5"),
            ItemModel(name: "Item 1"),
            ItemModel(name: "Item 2"),
            ItemModel(name: "Item 3"),
            ItemModel(name: "Item 4"),
            ItemModel(name: "Item 5")
        ]
    
    var body: some View {
        VStack {
            
            ListWithSeach(items: items) { item in
                Text(item.name)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(Color.blue)
            } searchBar: {
                Rectangle()
                    .frame(height: 80)
                    .padding(.horizontal)
            }
            .padding()
            .navigationTitle("Hide search bar")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
#Preview(body: {
    NavigationStack {
        ListContentView()
    }
})

struct ListWithSeach<Item: Identifiable, SearchBar: View, Content: View>: View {
    
    var axis: Axis.Set = .vertical
    var showIndicator: Bool = false
    @State private var tabState: Bool = true
    let items: [Item]
    let content: (Item) -> Content
    let searchBar: () -> SearchBar
    
    var body: some View {
        List(items) { item in
            content(item)
        }
        .listStyle(.plain)
        .overlay(alignment: .top) {
            searchBar()
                .animation(.easeInOut, value: tabState)
                .offset(y: tabState ? 0 : -100)
        }
        .background {
            GestureProxy {
                handleState($0)
            }
        }
    }
    
    func handleState(_ gesture: UIPanGestureRecognizer) {
        let offsetY = gesture.translation(in: gesture.view).y
        let velocityY = gesture.velocity(in: gesture.view).y
        
        if velocityY < 0 {
            // swipe up
            if -(velocityY / 10) > 70
                    && -(offsetY) > 80
                    && tabState == true {
                tabState = false
            }
        } else {
            // swipe down
            if (velocityY / 10) > 40
                && offsetY > 40
                && tabState == false {
                tabState = true
            }
        }
    }
}

struct SearchStateScrollView<SearchBar: View, Content: View>: View {
    var axis: Axis.Set = .vertical
    var showIndicator: Bool = false
    @State private var tabState: Bool = true
    var content: Content
    var searchBar: SearchBar
    
    init(axis: Axis.Set = .vertical,
         showIndicator: Bool = false,
         content: @escaping () -> Content,
         searchBar: @escaping () -> SearchBar) {
        
        self.axis = axis
        self.showIndicator = showIndicator
        self.content =  content()
        self.searchBar = searchBar()
    }
    
    var body: some View {
        if #available(iOS 17, *) {
            ScrollView(axis) {
                content
                    .padding(.top, 100)
            }
            .scrollIndicators(showIndicator ? .visible : .hidden)
            .overlay(alignment: .top) {
                searchBar
                    .animation(.easeInOut, value: tabState)
                    .offset(y: tabState ? 0 : -100)
            }
            .background {
                GestureProxy {
                    handleState($0)
                }
            }
        } else {
            ScrollView(axis, showsIndicators: showIndicator, content: {
                content
                    .padding(.top, 100)
            })
            .background {
                GestureProxy {
                    handleState($0)
                }
            }
        }
    }
    
    func handleState(_ gesture: UIPanGestureRecognizer) {
        let offsetY = gesture.translation(in: gesture.view).y
        let velocityY = gesture.velocity(in: gesture.view).y
        
        if velocityY < 0 {
            // swipe up
            if -(velocityY / 10) > 70
                    && -(offsetY) > 80
                    && tabState == true {
                tabState = false
            }
        } else {
            // swipe down
            if (velocityY / 10) > 40
                && offsetY > 40
                && tabState == false {
                tabState = true
            }
        }
    }
}


#Preview {
    NavigationStack {
        HideSearchBarOnScroll()
    }
}
