//
//  LFLoginViewController.swift
//  Finch
//
//  Created by Maarten de Vries on 11-12-16.
//  Copyright © 2016 Wrappic. All rights reserved.
//

import Foundation
import UIKit

class LFLoginViewController: UIViewController, SPTAudioStreamingDelegate {
    
    var player: SPTAudioStreamingController?
    
    var auth: SPTAuth?
    var authViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.player = SPTAudioStreamingController.sharedInstance()
        self.player?.delegate = self
        
        self.auth = SPTAuth.defaultInstance()
        
        self.auth?.clientID = "64b0170389324644ba6527eac1ff0af3"
        self.auth?.redirectURL = URL.init(string: "finch://")
        
        self.auth?.sessionUserDefaultsKey = LFConstants.SPOTIFY_SESSION_KEY
        self.auth?.requestedScopes = [SPTAuthStreamingScope]
        
        NotificationCenter.default.addObserver(self, selector: #selector(LFLoginViewController.handleSpotifyLogin), name: Notification.Name("handleSpotifyLogin"), object: nil)
    }
    
    func handleSpotifyLogin() {
        self.authViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        self.loginPlayer()
    }
    
    
    
    func loginPlayer() {
        
        DispatchQueue.main.async {
            self.player?.login(withAccessToken: self.auth?.session.accessToken)
        }
    }
    
    func startAuthFlow() {
        
        if let session = self.auth?.session {
            if session.isValid() {
                print("Session valid: start player login")
                self.loginPlayer()
                
            } else {
                self.openAuthViewController()
            }
        } else {
            self.openAuthViewController()
        }
    }
    
    @IBAction func connectWithSpotifyButtonPressed(_ sender: Any) {
        print("Connect with spotify")
        DispatchQueue.main.async {
             self.startAuthFlow()
        }
       
    }
    
    func openAuthViewController() {
        let authUrl = self.auth?.spotifyWebAuthenticationURL()
        self.authViewController = SFSafariViewController.init(url: authUrl!)
        
        self.present(self.authViewController!, animated: true, completion: nil)
    }
}
