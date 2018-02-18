//
//  AppDelegate.swift
//  Geodezja WTC
//
//  Created by Maciej Matuszewski on 12.02.2018.
//  Copyright © 2018 Maciej Matuszewski. All rights reserved.
//

import UIKit
import KVNProgress

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let tabBarController: UITabBarController = {
        let tabBarController = UITabBarController()
        let homeNavigationController = WTCNavigationController(rootViewController: HomeViewController(), tabBarIcon: #imageLiteral(resourceName: "home"), tabBarTitle: "Offers".localized)
        let jobsNavigationController = WTCNavigationController(rootViewController: JobsViewController(), tabBarIcon: #imageLiteral(resourceName: "jobs"), tabBarTitle: "Current jobs".localized)
        let contactNavigationController = WTCNavigationController(rootViewController: OfficesViewController(), tabBarIcon: #imageLiteral(resourceName: "building"), tabBarTitle: "Offices".localized)
        tabBarController.setViewControllers([homeNavigationController, jobsNavigationController, contactNavigationController], animated: false)
        return tabBarController
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        configure()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        return true
    }

    func configure() {
        initializeKVNProgress()

        let tabBar = UITabBar.appearance()
        tabBar.tintColor = .main
        tabBar.barTintColor = .white
        tabBar.shadowImage = UIImage()
        tabBar.isTranslucent = false


    }

    func initializeKVNProgress(){
        let config = KVNProgressConfiguration.init()
        config.backgroundTintColor = .white
        config.circleStrokeForegroundColor = UIColor(white: 0.3, alpha: 0.7)
        config.successColor = UIColor(white: 0.3, alpha: 0.7)
        config.statusColor = UIColor(white: 0.3, alpha: 0.7)
        config.errorColor = UIColor(white: 0.3, alpha: 0.7)
        config.isFullScreen = true
        KVNProgress.setConfiguration(config)
    }
}
