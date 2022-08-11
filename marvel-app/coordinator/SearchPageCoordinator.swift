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
    
    init(searchPageVC: SearchPageViewController){
        self.searchPageVC = searchPageVC
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
        searchPageVC.coordinator = self
        navigationController?.setViewControllers([searchPageVC], animated: true)
        return navigationController!
    }
    
    
}
