//
//  AppDelegate.swift
//  SlackWebAPIKit
//
//  Created by MoralAlberto on 08/12/2017.
//  Copyright (c) 2017 MoralAlberto. All rights reserved.
//

import UIKit
import SlackWebAPIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        API.sharedInstance.set(token: "xoxp-220728744260-221560162310-226324468387-6af7c5bc6bd21bb9a74f7f9ae1cc6c02")
        
        return true
    }
}

