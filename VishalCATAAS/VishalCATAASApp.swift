//
//  VishalCATAASApp.swift
//  VishalCATAAS
//
//  Created by Vishal Polepalli on 6/30/22.
//

import SwiftUI

@main
struct VishalCATAASApp: App {
    var container = DependencyContainer.create()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: .init(container: container))
        }
    }
}
