//
//  MockCatNetworkingService.swift
//  VishalCATAAS
//
//  Created by Vishal Polepalli on 7/1/22.
//

import Foundation
import Alamofire

class MockCatNetworkingService: DependencyContainer.Component, CatNetworkingServiceProtocol {
    
    private(set) var fetchRandomCatCount = 0
    private(set) var fetchAllCatsCount = 0
    private(set) var fetchCatsWithTagCount = 0
    private(set) var fetchCatsWithLimitCount = 0
    private(set) var fetchCatImageWithURLCount = 0
    private(set) var fetchCaptionCatImageCount = 0
    private(set) var fetchTagsCount = 0
    
    var fakeFetchRandomCatResult: DataResponse<CatModel, AFError>?
    var fakeFetchAllCatsResult: DataResponse<[CatModel], AFError>?
    var fakeFetchCatsWithTagResult: DataResponse<[CatModel], AFError>?
    var fakeFetchCatsWithLimitResult: DataResponse<[CatModel], AFError>?
    var fakeFetchCatImageWithURLResult: DataResponse<Data?, AFError>?
    var fakeFetchCaptionCatImageResult: DataResponse<Data?, AFError>?
    var fakeFetchTagsResult: DataResponse<[String], AFError>?
    
    
    func fetchRandomCat(completion: @escaping (DataResponse<CatModel, AFError>) -> Void) {
        fetchRandomCatCount += 1
        if let result = fakeFetchRandomCatResult {
            completion(result)
        }
    }
    
    func fetchAllCats(completion: @escaping (DataResponse<[CatModel], AFError>) -> Void) {
        fetchAllCatsCount += 1
        if let result = fakeFetchAllCatsResult {
            completion(result)
        }
    }
    
    func fetchCatsWithTag(tag: String, completion: @escaping (DataResponse<[CatModel], AFError>) -> Void) {
        fetchCatsWithTagCount += 1
        if let result = fakeFetchCatsWithTagResult {
            completion(result)
        }
    }
    
    func fetchCatsWithLimit(limit: String, completion: @escaping (DataResponse<[CatModel], AFError>) -> Void) {
        fetchCatsWithLimitCount += 1
        if let result = fakeFetchCatsWithLimitResult {
            completion(result)
        }
    }
    
    func fetchCatImageWithURL(id: String, url: URL, completion: @escaping (DataResponse<Data?, AFError>) -> Void) {
        fetchCatImageWithURLCount += 1
        if let result = fakeFetchCatImageWithURLResult {
            completion(result)
        }
    }
    
    func fetchCaptionCatImage(id: String, caption: String, completion: @escaping (DataResponse<Data?, AFError>) -> Void) {
        fetchCaptionCatImageCount += 1
        if let result = fakeFetchCaptionCatImageResult {
            completion(result)
        }
    }
    
    func fetchTags(completion: @escaping (DataResponse<[String], AFError>) -> Void) {
        fetchTagsCount += 1
        if let result = fakeFetchTagsResult {
            completion(result)
        }
    }
    
    
    

}

