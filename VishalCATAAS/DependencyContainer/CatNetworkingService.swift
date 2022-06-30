//
//  CatNetworkingService.swift
//  VishalCATAAS
//
//  Created by Vishal Polepalli on 6/30/22.
//

import Foundation
import Alamofire

protocol CatNetworkingServiceProtocol: AnyObject {
    func fetchWalletAddressQRLink(walletAddress: String, completion: @escaping (DataResponse<CatModel,AFError>) -> Void)
}

class CatNetworkingService: DependencyContainer.Component, CatNetworkingServiceProtocol {
    func fetchWalletAddressQRLink(walletAddress: String, completion: @escaping (DataResponse<CatModel, AFError>) -> Void) {
        let request = AF.request("https://cataas.com/cat?json=true")
        
        request.responseDecodable(of: CatModel.self) { (response) in
            switch response.result {
            case .success(let value):
                print("Success: ", value)
            case .failure(let error):
                print("Error: ", error)
            }
            completion(response)
        }
    }
    
        
}

