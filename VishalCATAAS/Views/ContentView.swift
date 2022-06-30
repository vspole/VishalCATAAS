//
//  ContentView.swift
//  VishalCATAAS
//
//  Created by Vishal Polepalli on 6/30/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

extension ContentView {
    class ViewModel: ObservableObject {
        private let container: DependencyContainer

        init(container: DependencyContainer) {
            self.container = container
        }
    }
}

