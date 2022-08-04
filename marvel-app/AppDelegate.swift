//
//  AppDelegate.swift
//  marvel-app
//
//  Created by Michal on 01/08/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let viewController = HomePageViewController()
        window?.rootViewController = viewController
        
        window?.makeKeyAndVisible()
        
        return true
    }



}

