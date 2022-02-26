//
//  AppDelegate.swift
//  DigitalShowroom
//
//  Created by Vikas Kharb on 30/01/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        let searchController = ProductListViewController()
        let navigationController = UINavigationController(rootViewController: searchController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }

}

