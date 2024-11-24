//
//  MenuView.swift
//  SwiftUIBootcamp
//
//  Created by Max Ward on 30/09/2023.
//

import SwiftUI

// Enum para las categorías
enum Category: String, Identifiable, CaseIterable {
    case layouts
    case navigation
    case animations
    case scrollview
    case grids
    case sliders
    case lists
    case GeometryReader
    case soundAndFeedback
    case Gestures
    case Components
    case UIs
    case others
    
    var id: String { self.rawValue }
    
    var displayName: String {
        switch self {
        case .animations:
            return "Animations Bootcamp"
        case .layouts:
            return "Layouts bootcamp"
        case .others:
            return "Otros"
        case .grids:
            return "Grid Bootcamp"
        case .scrollview:
            return "ScrollViews Bootcamp"
        case .sliders:
            return "Sliders Bootcamp"
        case .Components:
            return "Components"
        case .UIs:
            return "UIs"
        case .lists:
            return "Lists Bootcamp"
        case .GeometryReader:
            return "Gemetry Reader Bootcamp"
        case .soundAndFeedback:
            return "Sound and Feedback"
        case .navigation:
            return "Navigation Bootcamp"
        case .Gestures:
            return "Gestures Bootcamp"
        }
    }
    
    // Obtiene las vistas asociadas a cada categoría
    var views: [ViewDestination] {
        switch self {
        case .animations:
            return [.AIScreen, 
                .AIScreenV2,
                .HideTabOnScroll,
                .KeyframeAnimation, 
                .AnimatedButton]
        case .layouts:
            return [.RelativeFrame,
                .RelativeSizeLayout,
                .ContainerRelativeFrame,]
        case .scrollview:
            return [.VerticalScrollAnimation,
                .HideTabOnScroll,
                .HideTabOnChildView,
                .HideSearchView,
                .hideSearchbar,
                .ScrollTransition1,
                .RelativeScroll]
        case .Components:
            return [.ButtonView, .AnimatedButton]
        case .others:
            return [.CardTransition, .Heptic, .MovableGrid]
        case .grids:
            return [.MovableGrid]
        case .UIs:
            return [.CardCarousel, 
                .CardTransition,
                .AIScreen]
        case .lists: return []
        case .sliders:
            return [.ScrollTest,
                .ParametricSlider,
                .PageSliderControl]
        case .GeometryReader: return []
        case .soundAndFeedback:
            return [.Heptic]
        case .navigation: return []
        case .Gestures: return [
            .MovableGrid]
        }
    }
}

// Enum para las vistas dentro de cada categoría
enum ViewDestination: String, Identifiable, CaseIterable {
    case AIScreen // pantalla que muestra una animacion
    case AIScreenV2 // variacion de la pantalla
    case HideTabOnScroll // hides tabbar when user scrolls down
    case HideTabOnChildView // hides tabbar in child views
    case VerticalScrollAnimation
    case ScrollTest
    case ParametricSlider
    case CardTransition
    case PageSliderControl
    case ButtonView
    case CardCarousel
    case HideSearchView
    case Heptic
    case RelativeFrame
    case ContainerRelativeFrame
    case RelativeSizeLayout
    case hideSearchbar
    case ScrollTransition1
    case RelativeScroll
    case MovableGrid
    case AnimatedButton
    case KeyframeAnimation
    
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
            HepticBootcamp()
        case .HideSearchView:
            HideSearchBarOnScroll()
            // Layout
        case .RelativeFrame:
            RelativeFrameLayout()
        case .ContainerRelativeFrame:
            SimpleContainerRelativeFrame()
        case .RelativeSizeLayout:
            RelativeFrameScroll()
        case .hideSearchbar:
            HideSearchBarOnScroll()
        case .ScrollTransition1:
            ScrollTransitionExample1()
        case .RelativeScroll:
            RelativeFrameScroll()
        case .MovableGrid:
            MovableGridBootcamp()
        case .AnimatedButton:
            AnimatedButtonsBootcamp()
        case .KeyframeAnimation:
            KeyframeAnimationBootcamp()
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
        case .HideSearchView:
            return "Hide search view on scroll"
        case .RelativeFrame:
            return "Relative frame layout"
        case .ContainerRelativeFrame:
            return "Container relative frame"
        case .RelativeSizeLayout:
            return "Relative size layout"
        case .hideSearchbar:
            return "Hide Searchbar"
        case .ScrollTransition1:
            return "Scroll transition example 1"
        case .RelativeScroll:
            return "Relative scroll views"
        case .MovableGrid:
            return "Movable grid view"
        case .AnimatedButton:
            return "Animated button"
        case .KeyframeAnimation:
            return "Keyframe Animations"
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
