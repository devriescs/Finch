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
        
//        FIRApp.configure()
        
        self.auth = SPTAuth.defaultInstance()
        
        self.player = SPTAudioStreamingController.sharedInstance()
        self.player?.delegate = self

        DispatchQueue.main.async {
            
        }
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        if (self.auth?.canHandle(url))! {
            self.authViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            self.authViewController = nil
            
            self.auth?.handleAuthCallback(withTriggeredAuthURL: url, callback: { (error: Error?, session: SPTSession?) in
                
                if session != nil {
                    self.player?.login(withAccessToken: self.auth?.session.accessToken)
                }

            })
            
            return true
        }
        
        return false
    }
    
    func audioStreamingDidLogin(_ audioStreaming: SPTAudioStreamingController!) {
        
        self.player?.playSpotifyURI("", startingWith: 0, startingWithPosition: 0, callback: { (error: Error?) in
            if error != nil {
                print("ERROR: *** failed to play")
            }
        })
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

