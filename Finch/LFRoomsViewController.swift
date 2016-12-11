//
//  LFRoomsViewController.swift
//  Finch
//
//  Created by Maarten de Vries on 11-12-16.
//  Copyright © 2016 Wrappic. All rights reserved.
//

import Foundation
import UIKit

class LFRoomsViewController: UIViewController {
    
    var roomsRef: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.roomsRef = FIRDatabase.database().reference()
        
        self.roomsRef.observe(FIRDataEventType.childAdded, with: { (snapshot) -> Void in
            print("Child added \(snapshot)")
        })
        
        self.roomsRef.observe(FIRDataEventType.childRemoved, with: { (snapshot) -> Void in
            print("Child removed \(snapshot)")
        })
    }
}
