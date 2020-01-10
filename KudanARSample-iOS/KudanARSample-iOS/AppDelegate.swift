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
        ARAPIKey.sharedInstance().setAPIKey("Q1jUxIjVrKEmsDn6Ww6iCyKrCmztEwwDVzViifFmFnSNvcwZJQaRAirLErsJ6l0oaKUkslF+oOWRS2Vj9PCCdX77xUpaQAMZSfOJC8WtvYSLDXA2itC4nMTP75rw6Cl9lVdnmQfuy67WC8zhpk6A993ewi6SY7Ru3eV/AOIqhnvWb3oaI2BzA8epSADWSwzHaB4VpO11QXidN7658CRhDqoZQAPxqMRswRfEAyqaDIreCQeSme3BREgNGAHtqHkjDZ4TAQLQdX0BkoYQmG8nKM+LMyNI7hPmdPCydSQli3p/VoUzfs1a1Mw2qT6oKvbMHq8NyvWsDfHyvdKzjj1a7Zgj2EiTIZnQEl4MUSMUlwa7XaclcJ4if1AJFoXChS1z1hPMiadpdESSpeuX6EUGnHLDuULJ8UudfJnIcd9y437HizS781cVdgrH5Wli+owTzUl+WXFy7POVNW4oiDoR/Ix/3nB0v+zpYf37rAOhsnDHR/LYNnl3IZsnTwM0v0a52ti49d2PLFcKXAXliqOV6MmZgs5lU477F7jeoj4BdwVBWQh3FdCaWVILpk60DH0scTX0Yb5CS6aMsmedJbDPG1h6FTO+CDFW2OfxZ7yLMzT/IlLJ3rKkUsCAnCjgwazWmVoEV4pNr8TgNGm2NEvyNRiWxN+LMHBUPnp4hn8qYwY=")
        
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

