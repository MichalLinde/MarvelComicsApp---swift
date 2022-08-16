//
//  AppCoordinator.swift
//  marvel-app
//
//  Created by Michal on 11/08/2022.
//

import Foundation
import UIKit

class AppCoordinator: BaseCoordinator {
        
    let window: UIWindow?
    let vcContainer: ViewControllersContainer
    
    let homeNavController = UINavigationController()
    let searchNavController = UINavigationController()
    
    init(window: UIWindow?, vcContainer: ViewControllersContainer){
        self.window = window
        self.vcContainer = vcContainer
        window?.makeKeyAndVisible()
    }
    
    func start() {
        let tabBarController = setTabBarController()
        self.window?.rootViewController = tabBarController
        
    }
    
    func setTabBarController() -> UITabBarController {
        let tabBar = UITabBarController()
        let homePageCoordinator = HomePageCoordinator(vcContainer: vcContainer, navigationController: homeNavController)
        let searchPageCoordinator = SearchPageCoordinator(vcContainer: vcContainer, navigationController: searchNavController)
        
        UITabBar.appearance().unselectedItemTintColor = .gray
        UITabBar.appearance().tintColor = .red
        
        let homeItem = UITabBarItem(title: nil, image: UIImage(systemName: "house.fill"), tag: 0)
        let searchItem = UITabBarItem(title: nil, image: UIImage(systemName: "magnifyingglass"), tag: 1)
        
        let controllers: [UIViewController] = [ homePageCoordinator.start(), searchPageCoordinator.start() ]
        
        homePageCoordinator.navigationController?.tabBarItem = homeItem
        searchPageCoordinator.navigationController?.tabBarItem = searchItem
        
        tabBar.viewControllers = controllers
        return tabBar
    }
    
    
}
