//
//  ViewControllersContainer.swift
//  marvel-app
//
//  Created by Michal on 10/08/2022.
//

import Foundation
import Swinject

class ViewControllersContainer{
    static let sharedContainer = ViewControllersContainer()
    
    let container = Container()
    
    private init(){
        setupContainer()
    }
    
    func setupContainer(){
        let viewModelsContainer = ViewModelsContainer.sharedContainer.container
        
        container.register(HomePageViewController.self) {_ in
            return HomePageViewController(viewModel: viewModelsContainer.resolve(HomePageViewModel.self)!)
        }
        
        container.register(SearchPageViewController.self) {_ in
            return SearchPageViewController(viewModel: viewModelsContainer.resolve(SearchPageViewModel.self)!)
        }
        
        container.register(DetailsViewController.self) { _ in
            return DetailsViewController()
        }
    }
}
