//
//  BeaconViewController.swift
//  Adobe DMA Academy
//
//  Created by mrice on 9/10/16.
//  Copyright © 2016 Wessel Heringa. All rights reserved.
//

import UIKit
import CoreLocation


//var locationManager: CLLocationManager!

class BeaconViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: UUID(uuidString: "8492E75F-4FD6-469D-B132-043FE94921D8")!, identifier: "Estimotes");
    //UUID from Demo B9407F30-F5F8-466E-AFF9-25556B57FE6D
    //UUID for Virtual 8492E75F-4FD6-469D-B132-043FE94921D8
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.authorizedWhenInUse){
            locationManager.requestAlwaysAuthorization()
        }
        locationManager.startRangingBeacons(in: region)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        //print(beacons)
        
        for (ourBeacon) in beacons {
                    print("Known beacon found in range")
            //if ourBeacon.
            ADBMobile.trackBeacon(ourBeacon, data:nil)
        }
    }
    
    
}
