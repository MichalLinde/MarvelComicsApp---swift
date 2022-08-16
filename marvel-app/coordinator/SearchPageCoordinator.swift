//
//  SearchPageCoordinator.swift
//  marvel-app
//
//  Created by Michal on 11/08/2022.
//

import Foundation
import UIKit

class SearchPageCoordinator: Coordinator{
    var navigationController: UINavigationController?
    var searchPageVC: SearchPageViewController
    let vcContainer: ViewControllersContainer
    
    init(vcContainer: ViewControllersContainer, navigationController: UINavigationController){
        self.vcContainer = vcContainer
        self.navigationController = navigationController
        searchPageVC = vcContainer.container.resolve(SearchPageViewController.self)!
    }
    
    func eventOccured(with type: Event) {
        switch type {
        case .listElementClicked(let comic):
            let vc = vcContainer.container.resolve(DetailsViewController.self)!
            vc.comic = comic
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func start() -> UINavigationController{
        searchPageVC.coordinator = self
        navigationController?.setViewControllers([searchPageVC], animated: true)
        return navigationController!
    }
    
    
}
