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
    let homePageCoordinator: HomePageCoordinator
    let searchPageCoordinator: SearchPageCoordinator
    
    init(window: UIWindow?, homePageCoordinator: HomePageCoordinator, searchPageCoordinator: SearchPageCoordinator){
        self.window = window
        self.homePageCoordinator = homePageCoordinator
        self.searchPageCoordinator = searchPageCoordinator
        window?.makeKeyAndVisible()
    }
    
    func start() {
        let tabBarController = setTabBarController()
        self.window?.rootViewController = tabBarController
        
    }
    
    func setTabBarController() -> UITabBarController {
        let tabBar = UITabBarController()
        
        UITabBar.appearance().unselectedItemTintColor = .gray
        UITabBar.appearance().tintColor = .red
        
        let homeItem = UITabBarItem(title: nil, image: UIImage(systemName: "house.fill"), tag: 0)
        let searchItem = UITabBarItem(title: nil, image: UIImage(systemName: "magnifyingglass"), tag: 1)
        
        var controllers: [UIViewController] = []
        
        let homePageNC = homePageCoordinator.start()
        let searchPageNC = searchPageCoordinator.start()
        
        controllers.append(homePageNC)
        controllers.append(searchPageNC)
        
        homePageCoordinator.navigationController?.tabBarItem = homeItem
        searchPageCoordinator.navigationController?.tabBarItem = searchItem
        
        tabBar.viewControllers = controllers
        return tabBar
    }
    
    
}
