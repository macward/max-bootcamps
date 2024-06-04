//
//  MenuView.swift
//  SwiftUIBootcamp
//
//  Created by Max Ward on 30/09/2023.
//

import SwiftUI

// Enum para las categorías
enum Category: String, Identifiable, CaseIterable {
    case animations
    case layouts
    case scrollview
    case others
    case buttons
    case screens
    
    var id: String { self.rawValue }
    
    var displayName: String {
        switch self {
        case .animations:
            return "Animaciones"
        case .layouts:
            return "Layouts"
        case .others:
            return "Otros"
        case .scrollview:
            return "Scrolls"
        case .buttons:
            return "Buttons"
        case .screens:
            return "Screens"
        }
    }
    
    // Obtiene las vistas asociadas a cada categoría
    var views: [ViewDestination] {
        switch self {
        case .animations:
            return [.AIScreen, .AIScreenV2]
        case .layouts:
            return [.HideTabOnScroll, .HideTabOnChildView]
        case .scrollview:
            return [.VerticalScrollAnimation, .ScrollTest, .ParametricSlider, .PageSliderControl]
        case .buttons:
            return [.ButtonView, .Heptic]
        case .others:
            return [.CardTransition]
        case .screens:
            return [.CardCarousel]
        }
    }
}

// Enum para las vistas dentro de cada categoría
enum ViewDestination: String, Identifiable, CaseIterable {
    case AIScreen
    case AIScreenV2
    case HideTabOnScroll
    case HideTabOnChildView
    case VerticalScrollAnimation
    case ScrollTest
    case ParametricSlider
    case CardTransition
    case PageSliderControl
    case ButtonView
    case CardCarousel
    case Heptic
    
    var id: String { self.rawValue }
    
    @ViewBuilder
    var destinationView: some View {
        switch self {
        case .AIScreen:
            AIScreenView()
        case .AIScreenV2:
            InfiniteAnimation()
        case .HideTabOnScroll:
            HideOnScrollTabView()
        case .HideTabOnChildView:
            HideTabBar()
        case .VerticalScrollAnimation:
            VerticalScrollWithAnimation()
        case .ScrollTest:
            ScrollTestView()
        case .ParametricSlider:
            CustomPagingSliderScreen()
        case .CardTransition:
            CardTransitionView()
        case .PageSliderControl:
            ImagePagingSlider()
        case .ButtonView:
            ButtonsBootcamp()
        case .CardCarousel:
            CircularCarouselScreen()
        case .Heptic:
            SimpleHepticBootcamp()
        }
    }
    
    var displayName: String {
        switch self {
        case .AIScreen:
            return "AI Screen"
        case .AIScreenV2:
            return "AI Screen V2"
        case .HideTabOnScroll:
            return "Hide tab on scroll"
        case .HideTabOnChildView:
            return "Hide tab on child view"
        case .VerticalScrollAnimation:
            return "Vertical scroll with animation"
        case .ScrollTest:
            return "Scroll test view"
        case .ParametricSlider:
            return "Parametric slider"
        case .CardTransition:
            return "Card transition"
        case .PageSliderControl:
            return "Page slider control"
        case .ButtonView:
            return "Buttons bootcamp"
        case .CardCarousel:
            return "Card carousel"
        case .Heptic:
            return "Heptic bootcamp"
        }
    }
    
    var presentAsModal: Bool {
        switch self {
        case .HideTabOnChildView:
            return true
        default:
            return false
        }
    }
}

// Vista principal que muestra la lista de categorías
struct CategoryListView: View {
    var body: some View {
        NavigationStack {
            List(Category.allCases) { category in
                NavigationLink(destination: ViewListView(category: category)) {
                    Text(category.displayName)
                }
            }
            .navigationTitle("Categorías")
        }
    }
}

// Vista que muestra la lista de vistas dentro de una categoría
struct ViewListView: View {
    var category: Category
    @State private var selectedView: ViewDestination?
    
    var body: some View {
        List(category.views) { viewDestination in
            if viewDestination.presentAsModal {
                Button(action: {
                    selectedView = viewDestination
                }) {
                    Text(viewDestination.displayName)
                }
                .sheet(item: $selectedView) { view in
                    view.destinationView
                }
            } else {
                NavigationLink(destination: viewDestination.destinationView) {
                    Text(viewDestination.displayName)
                }
            }
        }
        .navigationTitle(category.displayName)
        .toolbar(.visible, for: .navigationBar)
    }
}
#Preview {
    CategoryListView()
}
