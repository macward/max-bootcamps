//
//  NativeTabView.swift
//  SwiftUIBootcamp
//
//  Created by Max Ward on 26/09/2023.
//

import SwiftUI

struct HideOnScrollTabView: View {
    
    @State private var tabState: Visibility = .visible
    @State private var presentDest: Bool = false
    
    var body: some View {
        TabView {
            NavigationStack {
                TabStateScrollView(axis: .vertical, showIndicator: false, tabState: $tabState) {
                    VStack (spacing: 12) {
                        ForEach(0..<10, id: \.self) { index in
                            GeometryReader(content: { proxy in
                                let size = proxy.size
                                Image("image \(index + 1)")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: size.width, height: size.height)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            })
                            .frame(height: 180)
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

struct TabStateScrollView<Content: View>: View {
    var axis: Axis.Set
    var showIndicator: Bool
    @Binding var tabState: Visibility
    var content: Content
    
    init(axis: Axis.Set,
         showIndicator: Bool,
         tabState: Binding<Visibility>, 
         content: @escaping () -> Content) {
        
        self.axis = axis
        self.showIndicator = showIndicator
        self._tabState = tabState
        self.content =  content()
    }
    
    var body: some View {
        if #available(iOS 17, *) {
            ScrollView(axis) {
                content
            }
            .scrollIndicators(showIndicator ? .visible : .hidden)
            .background {
                CustomGesture {
                    handleState($0)
                }
            }
        } else {
            ScrollView(axis, showsIndicators: showIndicator, content: {
                content
            })
            .background {
                CustomGesture {
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
                    && tabState == .visible {
                tabState = .hidden
            }
        } else {
            // swipe down
            if (velocityY / 10) > 40 
                && offsetY > 40 
                && tabState == .hidden {
                tabState = .visible
            }
        }
    }
}

fileprivate struct CustomGesture: UIViewRepresentable {
    
    var onChange: (UIPanGestureRecognizer) -> ()
    private let gestureID = UUID().uuidString
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(onChange: onChange)
    }
    
    func makeUIView(context: Context) -> some UIView {
        return UIView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        DispatchQueue.main.async {
            if let superView = uiView.superview?.superview, !(superView.gestureRecognizers?.contains(where: { $0.name == gestureID }) ?? false) {
                let gesture = UIPanGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.gestureChange(gestures:)))
                gesture.name = gestureID
                gesture.delegate = context.coordinator
                superView.addGestureRecognizer(gesture)
            }
        }
    }
    
    class Coordinator: NSObject, UIGestureRecognizerDelegate {
        
        var onChange: (UIPanGestureRecognizer) -> ()
        
        init(onChange: @escaping (UIPanGestureRecognizer) -> Void) {
            self.onChange = onChange
        }
        
        @objc
        func gestureChange(gestures: UIPanGestureRecognizer) {
            onChange(gestures)
        }
        
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }
    }
    
}

#Preview {
    HideOnScrollTabView()
}
