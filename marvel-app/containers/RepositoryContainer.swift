//
//  RepositoryContainer.swift
//  marvel-app
//
//  Created by Michal on 10/08/2022.
//

import Foundation
import Swinject

class RepositoryContainer {
    static let sharedContainer = RepositoryContainer()
    
    let container = Container()
    
    private init(){
        setupContainers()
    }
    
    func setupContainers(){
        container.register(ApiClientProtocol.self) {_ in
            return ApiClient()
        }.inObjectScope(.container)
        
        container.register(ComicsRepositoryProtocol.self) { resolver in
            return ComicsRepository(apiClient: resolver.resolve(ApiClientProtocol.self)!)
        }.inObjectScope(.container)
    }
}
