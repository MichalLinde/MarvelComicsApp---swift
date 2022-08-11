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
    
    init(homePageVC: HomePageViewController){
        self.homePageVC = homePageVC
    }
    
    func eventOccured(with type: Event) {
        switch type {
        case .listElementClicked(let comic):
            var vc: UIViewController & Coordinating = DetailsViewController(comic: comic)
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    func start() -> UINavigationController{
        navigationController = UINavigationController()
        homePageVC.coordinator = self
        navigationController?.setViewControllers([homePageVC], animated: true)
        return navigationController!
    }
    
    
}
