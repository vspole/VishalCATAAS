//
//  Endpoint.swift
//  VishalCATAAS
//
//  Created by Vishal Polepalli on 6/30/22.
//

import Foundation

enum Endpoint {
    private static let base = "https://cataas.com"
    
    static let cat = "\(base)/cat"
    static let catJson = "\(cat)?json=true"

}
