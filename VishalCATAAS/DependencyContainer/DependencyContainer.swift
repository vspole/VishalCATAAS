//
//  DependencyContainer.swift
//  AppFramework
//
//  Created by Vishal Polepalli on 6/28/22.
//

import Foundation

class DependencyContainer: ObservableObject, EntityProtocol {
    var components: [AnyObject] = []
    
}

extension DependencyContainer {
    class Component {
        unowned var entity: DependencyContainer
        
        init(entity: DependencyContainer) {
            self.entity = entity
        }
    }
    
    static func create() -> DependencyContainer {
        let container = DependencyContainer()
        container.components = [
            //Add Dependency Components Here
            CatNetworkingService(entity: container),
            ImageCacheManager(entity: container)
        ]
        return container
    }
}

// MARK: - Convenience property wrappers

extension DependencyContainer {
    var catNetworkingService: CatNetworkingServiceProtocol { getComponent() }
    var imageCache: ImageCacheManager { getComponent() }
}
