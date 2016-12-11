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
    
    var auth: SPTAuth?
    var authViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SPTAudioStreamingController.sharedInstance().delegate = self
        
        self.auth = SPTAuth.defaultInstance()
        
        self.auth?.clientID = "64b0170389324644ba6527eac1ff0af3"
        self.auth?.redirectURL = URL.init(string: "finch://")
        
        self.auth?.sessionUserDefaultsKey = LFConstants.SPOTIFY_SESSION_KEY
        self.auth?.requestedScopes = [SPTAuthStreamingScope]
        
        NotificationCenter.default.addObserver(self, selector: #selector(LFLoginViewController.handleSpotifyLogin), name: Notification.Name("handleSpotifyLogin"), object: nil)
    }
    
    func handleSpotifyLogin() {
        self.authViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        
        SPTAudioStreamingController.sharedInstance().login(withAccessToken: self.auth?.session.accessToken)
    }
    
    func audioStreamingDidLogin(_ audioStreaming: SPTAudioStreamingController!) {
        print("Audio streaming did login")
        
//        SPTAudioStreamingController.sharedInstance().playSpotifyURI("spotify:track:58s6EuEYJdlb0kO7awm3Vp", startingWith: 0, startingWithPosition: 0, callback: { (error: Error?) in
//            if error != nil {
//                print("ERROR: *** failed to play")
//            }
//        })
    }
    
    func startAuthFlow() {
        
        if let session = self.auth?.session {
            if session.isValid() {
                print("Session valid: start player login")
                SPTAudioStreamingController.sharedInstance().login(withAccessToken: self.auth?.session.accessToken)
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
