//
//  AppDelegate.swift
//  MeetupOrganizer
//
//  Created by Ayuna NYC on 11/29/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

import UIKit
import OAuthSwift 

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
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

    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        print("app: \(app)")
        print("url: \(url)")
        print("options: \(options)")
        
        

        if let sourceApplication = options[UIApplicationOpenURLOptionsKey.sourceApplication] { // called 3rd
            
            if (String(describing: sourceApplication) == "com.apple.mobilesafari") { // called 4th
                
                // the url that I get here is: meetuporganizer://oauth-callback/meetup?code=3e9b09ff43b9794df210295b634c3594&state=meetup1482513145
                
                //if (url.host == "oauth-callback") { // this doesn't get called
//                NotificationCenter.default.post(name: Notification.Name(rawValue: kCloseSafariViewControllerNotification), object: url)
                
                applicationHandle(url: url)
                
//                    OAuthSwift.handle(url: url)
                //}
            }
        }
        
        return true
        
        
//        // if (options["UIApplicationOpenURLOptionsSourceApplicationKey"] as? String == "com.apple.SafariViewService") {
//
//        
//        if let sourceApplication = options[UIApplicationOpenURLOptionsKey.sourceApplication] {
//            
//            if (String(describing: sourceApplication) == "com.apple.SafariViewService") {
//                NotificationCenter.default.post(name: Notification.Name(rawValue: kCloseSafariViewControllerNotification), object: url)
//                return true
//            }
//        }
//        
//        return true
    }
    
    
    func applicationHandle(url: URL) {
        if (url.host == "oauth-callback") {
            OAuthSwift.handle(url: url)
        } else {
            // Google provider is the only one wuth your.bundle.id url schema.
            OAuthSwift.handle(url: url)
        }
    }

}

