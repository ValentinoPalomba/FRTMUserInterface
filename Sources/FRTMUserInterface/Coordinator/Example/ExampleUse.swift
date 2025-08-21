//
//  ExampleUse.swift
//  FRTMUserInterface
//
//  Created by PALOMBA VALENTINO on 20/08/25.
//

import Foundation
import SwiftUI

// 1. Define your routes
public enum AppRoute: Route {
    case home
    case details(String)
}

// 2. Create a coordinator
@MainActor
public class AppCoordinator: Coordinator<AppRoute> {
    // You can add custom logic here if needed
}

// 4. Create a view model
@MainActor
public class HomeViewModel: BaseViewModel {
    var title: String {
        switch state {
            case .ready:
                return "Ready"
            default:
                return "Loading..."
        }
    }
    
    
    func retrieveData() async {
        try? await Task.sleep(for: .seconds(2))
        state = .ready
    }
}
@MainActor
public struct HomeView: BaseView {
    public typealias VM = HomeViewModel
    
    public var viewModel: HomeViewModel
    @EnvironmentObject var coordinator: AppCoordinator
    
    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack {
            Text(viewModel.title)
            Button("Go to Details") {
                Task {
                    await viewModel.retrieveData()
                    //coordinator.push(.details("Hello from home"))
                }
            }
        }
        .navigationTitle("Home")
    }
}

// 6. Define the state and events for another view
public struct DetailsState {
    var message: String
}

public enum DetailsEvent {
    case goBack
}

// 7. Create another view model
@MainActor
public class DetailsViewModel: BaseViewModel {
    let title: String
    init(title: String) {
        self.title = title
    }
}

// 8. Create another view
public struct DetailsView: @MainActor BaseView {
    public typealias VM = DetailsViewModel
    
    @State public var viewModel: DetailsViewModel
    @EnvironmentObject var coordinator: AppCoordinator
    
    public init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack {
            Text(viewModel.title)
            Button("Go Back") {
                coordinator.pop()
            }
        }
        .navigationTitle("Details")
    }
}

// 9. Create the main view
public struct ExampleApp: View {
    
    @EnvironmentObject var coordinator: AppCoordinator
    
    public var body: some View {
        CoordinatedNavigationStack(coordinator: coordinator) {
            HomeView(viewModel: HomeViewModel())
        } destination: { route in
            switch route {
            case .home:
                HomeView(viewModel: HomeViewModel())
            case .details(let message):
                DetailsView(viewModel: DetailsViewModel(title: message))
            }
        }
    }
}


#Preview {
    ExampleApp()
        .environmentObject(AppCoordinator())
}
