//
//  LFRoomViewController.swift
//  Finch
//
//  Created by Maarten de Vries on 11-12-16.
//  Copyright © 2016 Wrappic. All rights reserved.
//

import Foundation
import UIKit

class LFRoomViewController: UIViewController {
    
    var roomRef: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.roomRef = FIRDatabase.database().reference()
        
        self.roomRef.observe(FIRDataEventType.childChanged, with: { (snapshot) -> Void in
            // Song changed
        })
    }
}
