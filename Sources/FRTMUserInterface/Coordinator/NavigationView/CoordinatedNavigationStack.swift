//
//  CoordinatedNavigationStack.swift
//  FRTMUserInterface
//
//  Created by PALOMBA VALENTINO on 20/08/25.
//



import SwiftUI

/// A view that wraps SwiftUI's `NavigationStack` to work seamlessly with a `Coordinator`.
///
/// This component is generic over its content, destination view type, and route type,
/// ensuring full type safety without `AnyView`.
public struct CoordinatedNavigationStack<Content: View, Destination: View, R: Route>: View {
    
    /// The coordinator that manages the navigation state.
    @ObservedObject private var coordinator: Coordinator<R>
    
    /// The root view of the navigation stack.
    private let content: () -> Content
    
    /// The view builder that maps each route to its corresponding destination view.
    /// The `Destination` generic parameter is resolved by the `@ViewBuilder` to a
    /// single, concrete view type.
    private let destination: (R) -> Destination
    
    /// Initializes a new coordinated navigation stack.
    ///
    /// - Parameters:
    ///   - coordinator: The coordinator instance managing the navigation.
    ///   - content: A closure that returns the root view.
    ///   - destination: A closure that takes a route and returns the destination view.
    public init(
        coordinator: Coordinator<R>,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder destination: @escaping (R) -> Destination
    ) {
        self.coordinator = coordinator
        self.content = content
        self.destination = destination
    }
    
    public var body: some View {
        NavigationStack(path: $coordinator.path) {
            content()
                // Ora 'destination' restituisce un tipo concreto 'Destination',
                // che soddisfa il requisito del modificatore.
                .navigationDestination(for: R.self) { route in
                    destination(route)
                        .environment(\.presentationStyle, .push)
                }
                .sheet(item: $coordinator.sheet) { route in
                    destination(route)
                        .environment(\.presentationStyle, .sheet)
                }
            #if os(iOS) || os(tvOS)
                .fullScreenCover(item: $coordinator.fullScreenCover) { route in
                    destination(route)
                        .environment(\.presentationStyle, .fullScreenCover)
                }
            #endif
            
        }
        .environmentObject(coordinator)
    }
}


extension EnvironmentValues {
    @Entry var presentationStyle: PresentationStyle = .push
}
