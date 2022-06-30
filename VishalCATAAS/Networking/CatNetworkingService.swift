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

    
        
}

