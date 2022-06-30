//
//  ImageCacheManager.swift
//  VishalCATAAS
//
//  Created by Vishal Polepalli on 6/30/22.
//

import Foundation
import SwiftUI

protocol ImageCacheManagerProtocol {
    var cache: NSCache<NSString, UIImage> {get set}
    func get(forKey: String) -> UIImage?
    func set(forKey: String, image: UIImage)
}

class ImageCacheManager: DependencyContainer.Component, ImageCacheManagerProtocol  {
    var cache = NSCache<NSString, UIImage>()
    
    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
}
