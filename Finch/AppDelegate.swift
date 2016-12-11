//
//  AppDelegate.swift
//  Finch
//
//  Created by Maarten de Vries on 11-12-16.
//  Copyright © 2016 Wrappic. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, SPTAudioStreamingDelegate {

    var window: UIWindow?
    
    var auth: SPTAuth?
    var player: SPTAudioStreamingController?
    var authViewController: UIViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.auth = SPTAuth.defaultInstance()
        self.player = SPTAudioStreamingController.sharedInstance()
        
        self.auth?.clientID = ""
        self.auth?.redirectURL = URL.init(string: "")
        
        self.auth?.sessionUserDefaultsKey = LFConstants.SPOTIFY_SESSION_KEY
        self.auth?.requestedScopes = [SPTAuthStreamingScope]
        
        self.player?.delegate = self
        do {
            try self.player?.start(withClientId: self.auth?.clientID)
            
        } catch let error as Error {
            print("ERROR: There was a problem starting the Spotify SDK")
        }
        
        DispatchQueue.main.async {
            self.startAuthFlow()
        }
        
        return true
    }
    
    func startAuthFlow() {
    
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

