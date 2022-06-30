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
            container.catNetworkingService.getRandomCat { (response) in
                switch response.result {
                case .success(let value):
                    print("Sucess: ", value)
                case .failure(let error):
                    print("Error: ", error)
                }
            }
        }
    }
}

