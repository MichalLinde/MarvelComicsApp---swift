//
//  ViewModelsContainer.swift
//  marvel-app
//
//  Created by Michal on 10/08/2022.
//

import Foundation
import Swinject

class ViewModelsContainer {
    static let sharedContainer = ViewModelsContainer()
    
    let container = Container()
    
    private init(){
        setupContainers()
    }
    
    func setupContainers(){
        let repoContainer = RepositoryContainer.sharedContainer.container
        
        container.register(HomePageViewModel.self) { _ in
            return HomePageViewModel(repo: repoContainer.resolve(ComicsRepositoryProtocol.self)!)
        }
        
        container.register(SearchPageViewModel.self) { _ in
            return SearchPageViewModel(repo: repoContainer.resolve(ComicsRepositoryProtocol.self)!)
        }
    }
}
