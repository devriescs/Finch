//
//  LFRoomsViewController.swift
//  Finch
//
//  Created by Maarten de Vries on 11-12-16.
//  Copyright © 2016 Wrappic. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class LFRoomsViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    var roomsRef: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !CLLocationManager.locationServicesEnabled() {
            // Ask for Authorisation from the User.
            self.locationManager.requestAlwaysAuthorization()
            
            // For use in foreground
            self.locationManager.requestWhenInUseAuthorization()
            
            // Set the delegate to appdelegate
            self.locationManager.delegate = UIApplication.shared.delegate as! AppDelegate
        }
        
        self.roomsRef = FIRDatabase.database().reference()
        
//        let recentRoomsQuery = (roomsRef?.child("rooms").queryLimited(toFirst: 100))!
        
        self.roomsRef.observe(FIRDataEventType.value, with: { (snapshot) -> Void in
            
            print("Return value \(snapshot)")
            
//            for child in snapshot.children {
//            
//            }
        })
        
        self.roomsRef.observe(FIRDataEventType.childAdded, with: { (snapshot) -> Void in
            print("Child added \(snapshot)")
        })
        
        self.roomsRef.observe(FIRDataEventType.childRemoved, with: { (snapshot) -> Void in
            print("Child removed \(snapshot)")
        })
    }
}
