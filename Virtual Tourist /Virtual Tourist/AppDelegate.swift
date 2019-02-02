//
//  AppDelegate.swift
//  Virtual Tourist
//
//  Created by Bushra on 17/01/2019.
//  Copyright © 2019 Bushra Alkhushiban. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let dataController = DataController(modelName: "Photo+Pin")
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        dataController.load()
        let navigationController = window?.rootViewController as! UINavigationController
        let mapVC = navigationController.topViewController as! LocationViewController
        mapVC.dataController = dataController
        
        return true
    }
}
