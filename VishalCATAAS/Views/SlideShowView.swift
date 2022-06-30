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
                    ZStack(alignment: .bottomTrailing) {
                        Image(uiImage: viewModel.fetchImageFromCache(cat: cat))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .overlay(Color.black.opacity(0.4))
                            .tag(cat.id)
                            .frame(width: proxy.size.width, height: proxy.size.height/3)
                        
                        Button(action: {
                            viewModel.showShareSheet(cat: cat)
                        }, label: {
                            Image(systemName: "square.and.arrow.up")
                                    .foregroundColor(.blue)
                        })
                        .padding(.trailing, SIZE_PADDING_LARGE)
                        .padding(.bottom, SIZE_PADDING_LARGE)
                    }

                }
            }
            .tabViewStyle(PageTabViewStyle())
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .padding(.horizontal, MARGIN_SCREEN_LEFT_RIGHT)
            .frame(width: proxy.size.width, height: proxy.size.height/3)
            .background(ActivityViewController(items: $viewModel.shareSheetItems))
        }
    }
}
extension SlideShowView {
    class ViewModel: ObservableObject {
        private let container: DependencyContainer

        @Published var cats: [CatModel] = []
        @Published var catsCached: [CatModel] = []
        @Published var showImageText: Bool = true
        @Published var shareSheetItems: [Any] = []
        
        init(container: DependencyContainer) {
            self.container = container
            fetchAllCats()
        }
        
        func showShareSheet(cat: CatModel) {
            shareSheetItems.append(fetchImageFromCache(cat: cat))
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

