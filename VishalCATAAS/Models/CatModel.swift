//
//  CatModel.swift
//  VishalCATAAS
//
//  Created by Vishal Polepalli on 6/30/22.
//

import Foundation

struct CatModel: Decodable, Identifiable, Hashable {
    let id: String
    let date: String
    let tags: [String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case date = "created_at"
        case tags
    }
    
    var catURL: URL? {
        URL(string: String(format: Endpoint.catID,id))
    }
}
