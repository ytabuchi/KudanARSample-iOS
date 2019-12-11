//
//  AppDelegate.swift
//  KudanARSample-iOS
//
//  Created by Yoshito Tabuchi on 2018/07/24.
//  Copyright © 2018年 Yoshito Tabuchi. All rights reserved.
//

import UIKit
import KudanAR

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Add APIKey
        ARAPIKey.sharedInstance().setAPIKey("ovouHUtCPuTxet4uE3tealbf3MPdEfdk9oxoYDhl1pC7sXyGABQp7LwxAFLgmPqtj5ydzNq/lzDC+jfR5cK60/435sPD406FDg9bd+QVsqnUUDwBGd+B4k5DBDse6ikC61Ax3x+1GdGjgdIKu9qnOL6mNKDjQkIZXYrPeOyr2g4wyDI1v/scrIO7aXZ85EhC40wbN9vprwTYn+fo5LfTs/vTvZDyIIbo27M/5g3OPACoegqBINnh9Njla225o117bkpyJ/6GZw8B6ICYcl0Su12eS9q7ONaSX2QRAOQqwB9Q31cYFv5FaOc/W2P8/+3bv3Wh1eaRkjvmR76JDwo9bZlh4WLKHtVlWlv2CNR6vN8l5lo6IlGHY5ugYV1dP4KTImdLK1rv/j8OPxUZjKmIZJGERLYN+A0pzhbbA7smS/t0mB1WFeFfO4zG4GnSjvuIWU3av4k6R1+qBwE4sg5J9D9c6YB56OC9/510Pdg/C5U43/Lz91JfAdTdV81v8OGGH6RpKSU0AkzNSsOWMxRW3PgrUkHAPJRkt+scce7bKakxfdhHVQLbEkL2TsWB8fEJm0Bz9Pa94JY82CridPVtTi/aXe+GBPLktIIFDBM6q18yaLNASJ8kK9GsoLEfQFVxN8nBeHbMU/k2LYIQXTT0y2n1Zn7UvhnF7J3GEoN6o/E=")
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

