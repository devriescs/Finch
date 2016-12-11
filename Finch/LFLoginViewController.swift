//
//  LFLoginViewController.swift
//  Finch
//
//  Created by Maarten de Vries on 11-12-16.
//  Copyright © 2016 Wrappic. All rights reserved.
//

import Foundation
import UIKit

class LFLoginViewController: UIViewController {
    
    var auth: SPTAuth?
    var authViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.auth = SPTAuth.defaultInstance()
        
        self.auth?.clientID = "64b0170389324644ba6527eac1ff0af3"
        self.auth?.redirectURL = URL.init(string: "finch-login://")
        
        self.auth?.sessionUserDefaultsKey = LFConstants.SPOTIFY_SESSION_KEY
        self.auth?.requestedScopes = [SPTAuthStreamingScope]
        
    }
    
    func startAuthFlow() {
        
        if let session = self.auth?.session {
            if session.isValid() {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.player?.login(withAccessToken: self.auth?.session.accessToken)
            } else {
                self.openAuthViewController()
            }
        } else {
            self.openAuthViewController()
        }
    }
    
    @IBAction func connectWithSpotifyButtonPressed(_ sender: Any) {
        print("Connect with spotify")
        self.startAuthFlow()
    }
    func openAuthViewController() {
        let authUrl = self.auth?.spotifyWebAuthenticationURL()
        self.authViewController = SFSafariViewController.init(url: authUrl!)
        
        self.present(self.authViewController!, animated: true, completion: nil)
    }
}
