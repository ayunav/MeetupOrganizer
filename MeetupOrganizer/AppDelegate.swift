//
//  AppDelegate.swift
//  MeetupOrganizer
//
//  Created by Ayuna NYC on 11/29/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

import OAuthSwift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)

        if UserDefaults.standard.object(forKey: MeetupAccessToken) != nil {
            
            let eventsTableVC = storyboard.instantiateViewController(withIdentifier: "EventsNavigationViewController")
            
            self.window?.rootViewController = eventsTableVC
            
        } else {
            
            let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
            
            self.window?.rootViewController = loginVC
        }
        
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

    
    // MARK: - Open URL method 
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        if let sourceApplication = options[UIApplicationOpenURLOptionsKey.sourceApplication] {
            
            if (String(describing: sourceApplication) == "com.apple.mobilesafari") || (String(describing: sourceApplication) == "com.apple.SafariViewService") {
                
                if (url.host == "oauth-callback") {
                 
                    // posts notification to notification center, opens the app back from SFSafariVC
                    // SFSafariVC is dismissed, and LoginVC viewWillAppear is called
                    // handle url method sends the redirect uri + authorization code to the callback in authorize method in oathswift.authorize, which then extracts and stores the access token
                    
                    OAuthSwift.handle(url: url)
                }
            }
        }
        
        return true
    }

    
}

