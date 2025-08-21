//
//  BaseView.swift
//  FRTMUserInterface
//
//  Created by PALOMBA VALENTINO on 20/08/25.
//

import Foundation
import SwiftUI

@MainActor
public protocol BaseView: View {
    associatedtype VM: BaseViewModel
    
    var viewModel: VM { get }
    
    init(viewModel: VM)
}
