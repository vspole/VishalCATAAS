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
        NavigationView {
            VStack {
                Text("Welcome to Cat Heaven!")
                    .scaledFont(type: .openSansBold, size: 35, color: Color.blue)
                    .padding(.top, SIZE_PADDING_NORMAL)
                    .padding(.bottom, SIZE_PADDING_LARGE)
                catImage
                    .padding(.bottom, SIZE_PADDING_NORMAL)
                slideshowButton
                    .padding(.bottom, SIZE_PADDING_NORMAL)
                filterButton
                Spacer()

            }
            .padding(.horizontal, MARGIN_SCREEN_LEFT_RIGHT)
            .padding(.vertical, MARGIN_SCREEN_TOP_BOTTOM)
        }
    }
}
            
extension ContentView {
    private var catImage: some View {
        ZStack {
            AsyncImage(url: viewModel.catImageURl) { image in
                        image
                          .resizable()
                          .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 250, height: 250)
                    .onTapGesture {
                        viewModel.showImageText = false
                        viewModel.fetchRandomCat()
                    }
            if viewModel.showImageText {
                Text("Click me to load another cat!")
                    .scaledFont(type: .openSansSemiBold, size: 15, color: .white)
            }
        }

    }
    
    private var slideshowButton: some View {
        
        NavigationLink(destination: SlideShowView(viewModel: .init(container: viewModel.container))) {
            Text("Cat SlideShow")
                .scaledFont(type: .openSansSemiBold, size: 25, color: Color.blue)
        }
    }
    
    private var filterButton: some View {
        Button(action: {
            //Add button action here
        }, label: {
            Text("Filter Cats")
                .scaledFont(type: .openSansSemiBold, size: 25, color: Color.blue)
        })
    }
}


extension ContentView {
    class ViewModel: ObservableObject {
        let container: DependencyContainer

        @Published var catImageURl: URL?
        @Published var showImageText: Bool = true
        
        init(container: DependencyContainer) {
            self.container = container
            fetchRandomCat()
        }
        
        func fetchRandomCat() {
            container.catNetworkingService.fetchRandomCat() { [weak self] (response) in
                switch response.result {
                case .success(let value):
                    self?.catImageURl = URL(string: String(format: Endpoint.catID, value.id))
                case .failure(let error):
                    //Error handling here
                    print("Error: ", error)
                }
            }
        }
    }
}

