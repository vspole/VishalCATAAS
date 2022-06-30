//
//  CatNetworkingService.swift
//  VishalCATAAS
//
//  Created by Vishal Polepalli on 6/30/22.
//

import Foundation
import Alamofire

protocol CatNetworkingServiceProtocol: AnyObject {
    func getRandomCat(completion: @escaping (DataResponse<CatModel,AFError>) -> Void)
}

class CatNetworkingService: DependencyContainer.Component, CatNetworkingServiceProtocol {
    func getRandomCat(completion: @escaping (DataResponse<CatModel, AFError>) -> Void) {
        let request = AF.request(Endpoint.catJson)
        
        request.responseDecodable(of: CatModel.self) { (response) in
            completion(response)
        }
    }
    
        
}

