//
//  SlideShowView.swift
//  VishalCATAAS
//
//  Created by Vishal Polepalli on 6/30/22.
//

import SwiftUI

struct SlideShowView: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        if !viewModel.catsCached.isEmpty {
            slideshow
        }
    }
}

extension SlideShowView {
    var slideshow: some View {
        GeometryReader { proxy in
            TabView {
                ForEach(viewModel.catsCached) { cat in
                    Image(uiImage: viewModel.fetchImageFromCache(cat: cat))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .overlay(Color.black.opacity(0.4))
                        .tag(cat.id)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .padding(.horizontal, MARGIN_SCREEN_LEFT_RIGHT)
            .frame(width: proxy.size.width, height: proxy.size.height/3)
        }
    }
}
extension SlideShowView {
    class ViewModel: ObservableObject {
        private let container: DependencyContainer

        @Published var cats: [CatModel] = []
        @Published var catsCached: [CatModel] = []
        @Published var showImageText: Bool = true
        
        init(container: DependencyContainer) {
            self.container = container
            fetchAllCats()
            
        }
        
        func fetchAllCats() {
            container.catNetworkingService.fetchCatsWithLimit(limit: "30") { [weak self] (response) in
                switch response.result {
                case .success(let value):
                    self?.cats = value
                    self?.loadAllImages()
                    //print("Here: ", value)
                case .failure(let error):
                    //Error handling here
                    print("Error: ", error)
                }
            }
        }
        
        func loadAllImages() {
            for cat in cats {
                fetchImage(cat: cat)
                print("Cat: ", cat.id)
            }
            print("Done")
        }
        
        func fetchImage(cat: CatModel) {
            guard let catURL = cat.catURL else {
                return
            }
            container.catNetworkingService.fetchCatImageWithURL(id: cat.id, url: catURL) { [weak self] (response) in
                guard let data = response.data, let catImage = UIImage(data: data) else {
                    return
                }
                self?.catsCached.append(cat)
                self?.container.imageCache.set(forKey: cat.id, image: catImage)
            }
        }
        
        func fetchImageFromCache(cat: CatModel) -> UIImage {
            //There should not be a situation where the cached image doesn't exist because only cats that have been cached are being accessed here
            return container.imageCache.get(forKey: cat.id) ?? UIImage()
        }
    }
}

