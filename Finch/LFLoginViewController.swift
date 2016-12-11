//
//  LFLoginViewController.swift
//  Finch
//
//  Created by Maarten de Vries on 11-12-16.
//  Copyright © 2016 Wrappic. All rights reserved.
//

import Foundation
import UIKit

class LFLoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    var player: SPTAudioStreamingController?
    
    var auth: SPTAuth?
    var authViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        loginButton.delegate = self
        
        loginButton.center = self.view.center
        self.view.addSubview(loginButton)

    }
    
    func showMainViewController() {
        let mainVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainViewController")
        self.navigationController?.pushViewController(mainVC, animated: true)
    }
    
    /* MARK: Facebook login button delegate */
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
            
            if let error = error {
                // Handle error
                return
            }
            
            self.showMainViewController()
            
        }
    }

    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        //
    }
    
}
