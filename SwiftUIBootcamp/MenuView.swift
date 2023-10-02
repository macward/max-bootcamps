//
//  MenuView.swift
//  SwiftUIBootcamp
//
//  Created by Max Ward on 30/09/2023.
//

import SwiftUI

struct MenuItem: Identifiable {
    var id: UUID = UUID()
    var name: String
    var destination: AvailableViews
}

enum AvailableSections: String {
    case animation
    case sliders
    case scrolls
}

enum AvailableViews {
    case Empty
    case AIScreen
    case AIScreenV2
    case HideTabOnScroll
    case HideTabOnChildView
    case VerticalScrollWithAnimation
    case ScrollTestView
    case ParametricSlider
    case CardTransitionView
}

struct MenuView: View {
    
    private var menuItems: [MenuItem] = [
        .init(name: "AI Screen", destination: .AIScreen),
        .init(name: "AI Screen V2", destination: .AIScreenV2),
        .init(name: "Hide tab on scroll", destination: .HideTabOnScroll),
        .init(name: "Hide tab on child", destination: .HideTabOnChildView),
        .init(name: "Vertical Scroll with animation", destination: .VerticalScrollWithAnimation),
        .init(name: "Scroll Test view", destination: .ScrollTestView),
        .init(name: "Parametric Slider", destination: .ParametricSlider),
        .init(name: "Card Transition view", destination: .CardTransitionView)
    ]
    @State private var presentView: Bool = false
    @State private var selectedView: AvailableViews = .Empty
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(menuItems) { item in
                    Text(item.name)
                        .onTapGesture {
                            selectedView = item.destination
                            presentView.toggle()
                        }
                }
            }
            .navigationTitle("Menu")
            .sheet(isPresented: $presentView, content: {
                build(from: selectedView)
            })
        }
    }
    @ViewBuilder
    func build(from availableView: AvailableViews ) -> some View {
        switch availableView {
        case .Empty:
            EmptyView()
        case .AIScreen:
            AIScreenView()
        case .AIScreenV2:
            InfiniteAnimation()
        case .HideTabOnScroll:
            HideOnScrollTabView()
        case .HideTabOnChildView:
            HideTabBar()
        case .VerticalScrollWithAnimation:
            VerticalScrollWithAnimation()
        case .ScrollTestView:
            ScrollTestView()
        case .ParametricSlider:
            CustomPagingSliderScreen()
        case .CardTransitionView:
            CardTransitionView()
        }
    }
}

#Preview {
    MenuView()
}
