//
//  CoordinatorContainer.swift
//  marvel-app
//
//  Created by Michal on 11/08/2022.
//

import Foundation
import Swinject

class CoordinatorContainer {
    static let sharedContainer = CoordinatorContainer()
    
    let container = Container()
    
    private init(){
        setupContainer()
    }
    
    func setupContainer(){
        let vcContainer = ViewControllersContainer.sharedContainer.container
        
        container.register(HomePageCoordinator.self){ _ in
            return HomePageCoordinator(homePageVC: vcContainer.resolve(HomePageViewController.self)!)
        }
        
        container.register(SearchPageCoordinator.self){ _ in
            return SearchPageCoordinator(searchPageVC: vcContainer.resolve(SearchPageViewController.self)!)
        }
    }
}
