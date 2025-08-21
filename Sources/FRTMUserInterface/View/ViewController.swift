//
//  ViewController.swift
//  FRTMUserInterface
//
//  Created by PALOMBA VALENTINO on 21/08/25.
//

import SwiftUI
#if canImport(UIKit)
import UIKit

open class ViewController<ViewModel: BaseViewModel>: UIViewController {
    var viewModel: ViewModel!
    
}

public struct ViewControllerRepresentable<ViewModel: BaseViewModel>: UIViewControllerRepresentable {
    
    @State var viewModel: ViewModel
    let content: () -> ViewController<ViewModel>
    let updateContent: ((ViewController<ViewModel>) -> Void)?
    
    public init(viewModel: ViewModel, @ViewBuilder content: @escaping () -> ViewController<ViewModel>, updateContent: ((ViewController<ViewModel>) -> Void)? = nil) {
        self.viewModel = viewModel
        self.content = content
        self.updateContent = updateContent
    }
    
    public typealias UIViewControllerType = ViewController<ViewModel>
    
    public func makeUIViewController(context: Context) -> ViewController<ViewModel> {
        let content = content()
        content.viewModel = viewModel
        return content
    }
    
    public func updateUIViewController(
        _ uiViewController: UIViewControllerType,
        context: Context
    ) {
        updateContent?(uiViewController)
    }
}

#endif

#if canImport(AppKit) && os(macOS)

import AppKit

open class ViewController<ViewModel>: NSViewController {
    var viewModel: ViewModel!
}

public struct ViewControllerRepresentable<ViewModel: BaseViewModel>: NSViewControllerRepresentable {
    @State var viewModel: ViewModel
    let content: () -> ViewController<ViewModel>
    let updateContent: ((ViewController<ViewModel>) -> Void)?
    
    public init(viewModel: ViewModel, @ViewBuilder content: @escaping () -> ViewController<ViewModel>, updateContent: ((ViewController<ViewModel>) -> Void)? = nil) {
        self.viewModel = viewModel
        self.content = content
        self.updateContent = updateContent
    }
    
    public func makeNSViewController(context: Context) -> ViewController<ViewModel> {
        let content = content()
        content.viewModel = viewModel
        return content
    }

    public func updateNSViewController(
        _ nsViewController: ViewController<ViewModel>,
        context: Context
    ) {
        updateContent?(nsViewController)
    }

    public typealias NSViewControllerType = ViewController<ViewModel>
    
}

#endif
