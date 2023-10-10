//
//  PropertyWrappers.swift
//  SwiftUIBootcamp
//
//  Created by Max Ward on 06/10/2023.
//

import SwiftUI


// Custom property wrapper para UserDefaults
@propertyWrapper
struct UserDefault<T> {
    
    var key: String
    var defaultValue: T
    
    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

// Custom environment Keys
private struct BackgroundColorKey: EnvironmentKey {
    typealias Value = Color
    static var defaultValue: Value = .red
}

// add environment key
extension EnvironmentValues {
    var backgroundColor: Color {
        get { self[BackgroundColorKey.self] }
        set { self[BackgroundColorKey.self] = newValue }
    }
}

private struct URLSessionKey: EnvironmentKey {
    static var defaultValue: URLSession = {
       fatalError("Attempt to read URLSession but it is not injected")
    }()
}

extension EnvironmentValues {
    var urlSession: URLSession {
        get { self[URLSessionKey.self] }
        set { self[URLSessionKey.self] = newValue }
    }
}

struct GenericObject: Codable {
    var name: String
}

@propertyWrapper
struct RemoteData: DynamicProperty {
    
    // Ademas, siempre usar structs para las dynamic properties
    
    // State es importanmte de lo contrario no funcionara
    @State var wrappedValue: GenericObject = .init(name: "")
    @Environment(\.urlSession) var urlSession // utiliza el environent para injectar urlsession
    private var url: URL
    
    // siempre debe haber un initializer para las propieades, en este caso URL
    init(url: URL) {
        self.url = url
    }
    
    // update conforma el protocolo Dynamic
    func update() {
        fetchData()
    }
    
    private func fetchData() {
        urlSession.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data else {
                return
            }
            self.wrappedValue = try! JSONDecoder().decode(GenericObject.self, from: data)
        }
    }
}

struct PropertyWrapperTest: View {
    
    @Environment(\.backgroundColor) var backgroundColor
    @RemoteData(url: URL(string: "sample")!) var object: GenericObject
    @UserDefault("has_seen_introduction", defaultValue: false)
    static var hasSeenIntroduction: Bool
    
    var body: some View {
        Text("Hello, World!")
            .background(backgroundColor)
            .environment(\.urlSession, URLSession.shared)
    }
}

#Preview {
    PropertyWrapperTest()
}
