//
//  CatsModel.swift
//  VishalCATAAS
//
//  Created by Vishal Polepalli on 6/30/22.
//

import Foundation

struct CatsModel: Decodable {
    let all: [CatModel]

    enum CodingKeys: String, CodingKey {
        case all = ""
    }
}
