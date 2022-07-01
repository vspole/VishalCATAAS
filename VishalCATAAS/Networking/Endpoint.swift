//
//  Endpoint.swift
//  VishalCATAAS
//
//  Created by Vishal Polepalli on 6/30/22.
//

import Foundation

enum Endpoint {
    private static let base = "https://cataas.com"
    private static let api = "\(base)/api"
    
    static let cat = "\(base)/cat"
    static let catID = "\(cat)/%@" // %@ = cat ID
    static let catJson = "\(cat)?json=true"
    static let caption = "\(catID)/says/%@"// %@ = caption

    static let cats = "\(api)/cats"
    static let catsTag = "\(cats)?tags=%@" // %@ = tag
    static let catsLimit = "\(cats)?limit=%@" // %@ = limit"
    
    static let tags = "\(api)/tags"
}
