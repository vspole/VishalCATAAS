//
//  FiltersView.swift
//  VishalCATAAS
//
//  Created by Vishal Polepalli on 6/30/22.
//

import SwiftUI

struct FiltersView: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.tags, id: \.self) { tag in
                    NavigationLink(destination: SlideShowView(viewModel: .init(container: viewModel.container, tag: tag))) {
                        Text(tag)
                            .scaledFont(type: .openSansSemiBold, size: 25)
                    }
                }
            }
        }
        .padding(.horizontal, MARGIN_SCREEN)
    }
}

extension FiltersView {
    class ViewModel: ObservableObject {
        let container: DependencyContainer
        
        @Published var tags: [String] = []
        init(container: DependencyContainer) {
            self.container = container
            fetchTags()
        }
        
        private func fetchTags() {
            container.catNetworkingService.fetchTags() { [weak self] (response) in
                switch response.result {
                case .success(let value):
                    self?.tags = value
                case .failure(let error):
                    print("Error: ", error)
                }
            }
        }
    }
}
