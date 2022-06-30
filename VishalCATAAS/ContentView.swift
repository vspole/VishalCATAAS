//
//  ContentView.swift
//  VishalCATAAS
//
//  Created by Vishal Polepalli on 6/30/22.
//

import SwiftUI

struct ContentView: View {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
