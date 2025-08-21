# FRTMUserInterface
![Swift](https://img.shields.io/badge/Swift-6.0-orange.svg)
![iOS](https://img.shields.io/badge/iOS-17.0%2B-blue.svg)

A powerful and elegant Swift UI framework designed to streamline the development of modern iOS applications. `FRTMUserInterface` provides a robust Coordinator pattern and `BaseView` architecture to build scalable, maintainable, and testable user interfaces with SwiftUI.

## Overview

`FRTMUserInterface` simplifies navigation and state management in SwiftUI by providing a clean, protocol-oriented architecture. It leverages the Coordinator pattern to decouple navigation logic from your views, making your codebase cleaner and easier to reason about. The framework is built on top of modern Swift and SwiftUI features, ensuring a seamless development experience.

## Features

- **Coordinator Pattern:** Decouple navigation logic from views for better separation of concerns.
- **`CoordinatedNavigationStack`:** A custom `NavigationStack` that integrates seamlessly with your coordinator.
- **`BaseView` & `BaseViewModel`:** A protocol-oriented approach to building views and view models, promoting code reuse and testability.
- **Type-Safe Routing:** Define your navigation routes using enums for compile-time safety.
- **Swift-Native:** Built with modern Swift and SwiftUI, ensuring optimal performance and compatibility.

## Installation

To add `FRTMUserInterface` to your project, add it as a package dependency in your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/your-username/FRTMUserInterface.git", from: "1.0.0")
]
```

## Usage

### 1. Define Your Routes

First, define all possible navigation routes in your app using an enum that conforms to the `Route` protocol.

```swift
import FRTMUserInterface

public enum AppRoute: Route {
    case home
    case details(String)
}
```

### 2. Create a Coordinator

Create a coordinator class that inherits from `Coordinator` and specify your `AppRoute` as the generic type.

```swift
import FRTMCore

@MainActor
public class AppCoordinator: Coordinator<AppRoute> {
    // You can add custom navigation logic here if needed
}
```

### 3. Build Your Views

Create your views by conforming to the `BaseView` protocol. This ensures that your views are linked to a `BaseViewModel` and have access to the coordinator through the environment.

**ViewModel:**
```swift
import FRTMUserInterface

@MainActor
public class HomeViewModel: BaseViewModel {
    // Your view logic and state
}
```

**View:**
```swift
import SwiftUI
import FRTMUserInterface

public struct HomeView: BaseView {
    public var viewModel: HomeViewModel
    @EnvironmentObject var coordinator: AppCoordinator

    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        VStack {
            Text("Welcome to the Home View!")
            Button("Go to Details") {
                coordinator.push(.details("Hello from Home!"))
            }
        }
        .navigationTitle("Home")
    }
}
```

### 4. Assemble in the Main App

Finally, use the `CoordinatedNavigationStack` in your main app view to manage the navigation flow. The stack uses your coordinator to push and pop views based on the routes you define.

```swift
import SwiftUI
import FRTMUserInterface

public struct ExampleApp: View {
    
    @StateObject private var coordinator = AppCoordinator()
    
    public var body: some View {
        CoordinatedNavigationStack(coordinator: coordinator) {
            // The initial view in the stack
            HomeView(viewModel: HomeViewModel())
        } destination: { route in
            // The view to navigate to for a given route
            switch route {
            case .home:
                HomeView(viewModel: HomeViewModel())
            case .details(let message):
                DetailsView(viewModel: DetailsViewModel(title: message))
            }
        }
        .environmentObject(coordinator)
    }
}
```

## License

FRTMUserInterface is released under the MIT license. See [LICENSE](LICENSE) for details.