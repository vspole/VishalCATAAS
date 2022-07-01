//
//  CatNetworkingService.swift
//  VishalCATAAS
//
//  Created by Vishal Polepalli on 6/30/22.
//

import Foundation
import Alamofire

protocol CatNetworkingServiceProtocol: AnyObject {
    func fetchRandomCat(completion: @escaping (DataResponse<CatModel,AFError>) -> Void)
    func fetchAllCats(completion: @escaping (DataResponse<[CatModel], AFError>) -> Void)
    func fetchCatsWithTag(tag: String, completion: @escaping (DataResponse<[CatModel], AFError>) -> Void)
    func fetchCatsWithLimit(limit: String, completion: @escaping (DataResponse<[CatModel], AFError>) -> Void)
    func fetchCatImageWithURL(id: String, url: URL, completion: @escaping (DataResponse<Data?, AFError>) -> Void)
    func fetchCaptionCatImage(id: String, caption: String, completion: @escaping (DataResponse<Data?, AFError>) -> Void)
    func fetchTags(completion: @escaping (DataResponse<[String], AFError>) -> Void) 
}

class CatNetworkingService: DependencyContainer.Component, CatNetworkingServiceProtocol {
    func fetchRandomCat(completion: @escaping (DataResponse<CatModel, AFError>) -> Void) {
        let request = AF.request(Endpoint.catJson)
        
        request.responseDecodable(of: CatModel.self) { (response) in
            completion(response)
        }
    }
    
    func fetchAllCats(completion: @escaping (DataResponse<[CatModel], AFError>) -> Void) {
        let request = AF.request(Endpoint.cats)
        
        request.responseDecodable(of: [CatModel].self) { (response) in
            completion(response)
        }
    }
    
    func fetchCatsWithTag(tag: String, completion: @escaping (DataResponse<[CatModel], AFError>) -> Void) {
        let request = AF.request(String(format: Endpoint.catsTag, tag))
        
        request.responseDecodable(of: [CatModel].self) { (response) in
            completion(response)
        }
    }
    
    func fetchCatsWithLimit(limit: String, completion: @escaping (DataResponse<[CatModel], AFError>) -> Void) {
        let request = AF.request(String(format: Endpoint.catsLimit, limit))
        
        request.responseDecodable(of: [CatModel].self) { (response) in
            completion(response)
        }
    }
    func fetchCatImageWithURL(id: String, url: URL, completion: @escaping (DataResponse<Data?, AFError>) -> Void) {
        let request = AF.request(url)
        
        request.response() { (response) in

            completion(response)
        }
    }
    
    func fetchCaptionCatImage(id: String, caption: String, completion: @escaping (DataResponse<Data?, AFError>) -> Void ) {
        
        let request = AF.request(String(format: Endpoint.caption, id, caption))
        
        request.response() { (response) in
            completion(response)
        }
    }
    
    func fetchTags(completion: @escaping (DataResponse<[String], AFError>) -> Void) {
        let request = AF.request(Endpoint.tags)
        
        request.responseDecodable(of: [String].self) { (response) in
            completion(response)
        }
    }
}

