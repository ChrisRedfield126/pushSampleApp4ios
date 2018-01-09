//
//  GeolocationViewController.swift
//  Adobe DMA Academy
//
//  Created by mrice on 9/8/16.
//  Copyright © 2016 Wessel Heringa. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

class GeolocationViewController: UIViewController, CLLocationManagerDelegate {
    
    let region = CLBeaconRegion(proximityUUID: UUID(uuidString: "8492E75F-4FD6-469D-B132-043FE94921D8")!, identifier: "Estimotes");
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    var locations = [MKPointAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pagename = "dma:mob:geolocation"
        ADBMobile.trackState(pagename, data:nil)
    }
    
    
    lazy var locationManager: CLLocationManager! = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestAlwaysAuthorization()
        if #available(iOS 9.0, *){
            manager.allowsBackgroundLocationUpdates = true
        }
        return manager
    }()
    
    
    @IBAction func enabledChanged(_ sender: UISwitch) {
        if sender.isOn {
            locationManager.startUpdatingLocation()
        } else {
            locationManager.stopUpdatingLocation()
        }
    }
    
    @IBAction func accuracyChanged(_ sender: UISegmentedControl) {
        let accuracyValues = [
            kCLLocationAccuracyBestForNavigation,
            kCLLocationAccuracyBest,
            kCLLocationAccuracyNearestTenMeters,
            kCLLocationAccuracyHundredMeters,
            kCLLocationAccuracyKilometer,
            kCLLocationAccuracyThreeKilometers]
        
        locationManager.desiredAccuracy = accuracyValues[sender.selectedSegmentIndex];
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //Get Current Location
        let location = locations.last! as CLLocation
        let userLocation:CLLocation = locations[0] as CLLocation
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude)
        myAnnotation.title = "Current location"
        mapView.addAnnotation(myAnnotation)
        NSLog(String(format:"%f", userLocation.coordinate.latitude))
        
        if UIApplication.shared.applicationState == .active {
            mapView.addAnnotation(myAnnotation)
            NSLog(String(format:"%f, %f", userLocation.coordinate.latitude, userLocation.coordinate.longitude))
        }
        else {
            ADBMobile.trackLocation(userLocation, data:nil);
            NSLog("App is backgrounded. New location is %@", userLocation)
        }
    }
    
}
