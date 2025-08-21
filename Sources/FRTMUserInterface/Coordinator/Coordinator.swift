//
//  Coordinator.swift
//  FRTMUserInterface
//
//  Created by PALOMBA VALENTINO on 20/08/25.
//

import Foundation
import SwiftUI

/// The main object that manages the navigation stack.
///
/// This object holds the `NavigationPath` and provides methods to manipulate it.
/// It is an `ObservableObject`, so views can subscribe to its changes.
public enum PresentationStyle {
    case sheet
    case fullScreenCover
    case push
}

@MainActor
open class Coordinator<R: Route>: ObservableObject {
    
    /// The current navigation path. Bind this to your `NavigationStack`.
    @Published public var path = NavigationPath()
    
    /// Il percorso corrente da presentare come sheet.
    @Published public var sheet: R?
    
    /// Il percorso corrente da presentare come fullscreenCover.
    @Published public var fullScreenCover: R?
    
    public init() {}
    
    /// Pushes a new route onto the navigation stack.
    /// - Parameter route: The route to navigate to.
    public func push(_ route: R) {
        path.append(route)
    }
    
    /// Pops the last view from the navigation stack.
    public func pop() {
        path.removeLast()
    }
    
    /// Pops a specific number of views from the navigation stack.
    /// - Parameter count: The number of views to pop. Defaults to 1.
    public func pop(count: Int) {
        path.removeLast(count)
    }
    
    /// Pops the navigation stack to the root view.
    public func popToRoot() {
        path.count > 1 ? path.removeLast(path.count - 1) : ()
    }
    
    // MARK: - Sheet Operations
    
    /// Presenta una rotta come sheet.
    /// - Parameter route: La rotta da presentare.
    public func presentSheet(_ route: R) {
        self.sheet = route
    }
    
    /// Chiude il sheet attualmente presentato.
    public func dismissSheet() {
        self.sheet = nil
    }
    
    
    public func close(with presentationStyle: PresentationStyle) {
        switch presentationStyle {
            case .sheet:
                dismissSheet()
            case .fullScreenCover:
                dismissFullScreenCover()
            case .push:
                pop()
        }
    }
    
    // MARK: - FullScreenCover Operations
    
    /// Presenta una rotta come fullscreenCover.
    /// - Parameter route: La rotta da presentare.
    public func presentFullScreenCover(_ route: R) {
        self.fullScreenCover = route
    }
    
    /// Chiude il fullscreenCover attualmente presentato.
    public func dismissFullScreenCover() {
        self.fullScreenCover = nil
    }

}
