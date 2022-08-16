//
//  HomePageCoordinator.swift
//  marvel-app
//
//  Created by Michal on 11/08/2022.
//

import Foundation
import UIKit

class HomePageCoordinator: Coordinator {
    var navigationController: UINavigationController?
    var homePageVC: HomePageViewController
    let vcContainer: ViewControllersContainer
    
    init(vcContainer: ViewControllersContainer, navigationController: UINavigationController){
        self.vcContainer = vcContainer
        self.navigationController = navigationController
        self.homePageVC = vcContainer.container.resolve(HomePageViewController.self)!
    }
    
    func eventOccured(with type: Event) {
        switch type {
        case .listElementClicked(let comic):
            let vc = vcContainer.container.resolve(DetailsViewController.self)!
            vc.comic = comic
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    func start() -> UINavigationController{
        homePageVC.coordinator = self
        navigationController?.setViewControllers([homePageVC], animated: true)
        return navigationController!
    }
    
    
}
