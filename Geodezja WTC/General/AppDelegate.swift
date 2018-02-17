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
        let contactNavigationController = WTCNavigationController(rootViewController: ContactViewController(), tabBarIcon: #imageLiteral(resourceName: "contact"), tabBarTitle: "Contact".localized)
        tabBarController.setViewControllers([homeNavigationController, jobsNavigationController, contactNavigationController], animated: false)
        return tabBarController
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        configureExternalTools()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        return true
    }

    func configureExternalTools() {
        initializeKVNProgress()
    }

    func initializeKVNProgress(){
        let config = KVNProgressConfiguration.init()
        config.backgroundTintColor = .background
        config.circleStrokeForegroundColor = .black
        config.successColor = .black
        config.statusColor = .black
        config.errorColor = .black
        config.isFullScreen = true
        KVNProgress.setConfiguration(config)
    }
}
