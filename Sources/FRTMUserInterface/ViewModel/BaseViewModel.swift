//
//  BaseViewModel.swift
//  FRTMUserInterface
//
//  Created by PALOMBA VALENTINO on 20/08/25.
//

import Foundation
import SwiftUI


/// A base class for view models that provides a basic implementation of the `ViewModel` protocol.
///
/// This class uses the `@Observable` macro to automatically make its properties observable.
@MainActor
@Observable
open class BaseViewModel {
    
    public enum ViewState {
        case loading
        case ready
        case idle
        case error(Error)
    }
    
    /// The current state of the view.
    public var state: ViewState = .idle
    
    
}

