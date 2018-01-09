    //
//  LoginViewController.swift
//  wesbites
//
//  Created by Wessel Heringa on 2016.
//  Copyright © 2016 Wessel Heringa. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    fileprivate func log(_ message:String){
        print("log: \(message)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        /** Application Logic
        *
        * Tap anywhere on screen unloads the keyboard (and shows the login button)
        **/
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        /** Adobe Mobile SDK logic
         *
         *
         *
         * Set Analytics variable
         **/
        
        let crm_id = UserModel.getInstance().crm_id
        let authstate = UserModel.getInstance().authstate
        
        if(authstate=="Logged in" || true){
            let visitorIDs: [String:String] = ["'x_device_id":"\(crm_id)"]
            ADBMobile.visitorSyncIdentifiers(visitorIDs,authenticationState:ADBMobileVisitorAuthenticationState.authenticated)
        }
        
        
        let pagename = "dma:mob:login"
        let analyticsData: [String:String] = [
            "pagename":"\(pagename)",
            "device":"mobile",
            "category":"home",
            "crm_id" : "\(crm_id)",
            "authstate": "\(authstate)",
            ]
        ADBMobile.trackState(pagename, data:analyticsData as [AnyHashable: Any])
        
        
        //let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)
        //backgroundImage.image = UIImage(named: "clouds4")
        //self.view.insertSubview(backgroundImage, atIndex: 0)
        
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBOutlet weak var loginText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var authStateLabel: UILabel!
    
    
    /**
     * Called when the user pushes the 'login button'
     **/
    @IBAction func loginClicked(_ sender: UIButton) {
        let password = passwordText.text!
        let username = loginText.text!
        authStateLabel.text = "Authenticating...."

        /**
         * Call to CRM webservice, returns true if login was successful
        **/
        if(UserModel.getInstance().login(username, password:password)){
           
            /**
             * Okay, succesfully logged in. Proceed with registring in campaign and tracking in analytics
             **/
            LoggerModel.getInstance().log("login successful, crm_id is \(UserModel.getInstance().crm_id)")
            
            /**
             * Start tracking event in Analytics
             **/
            let authstate = UserModel.getInstance().authstate
            authStateLabel.text = "Success"
            let crm_id = UserModel.getInstance().crm_id
            if(authstate=="Logged in"){
                let visitorIDs: [String:String] = ["'x_device_id":"\(crm_id)"]
                ADBMobile.visitorSyncIdentifiers(visitorIDs,authenticationState:ADBMobileVisitorAuthenticationState.authenticated)
            }
            
            /** 
             PB, use pushidentifier variable from app delegate, mid and call campaign collectPII call to register in Campaign 
             **/
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
           
            /* placeholder collectPII */
            
            //let tracklocationData: [String:String] = [
            //    "tracklocation":"y"
            //]
            //let latitude: CLLocationDegrees = 52.31
            //let longitude: CLLocationDegrees = 4.94
            //let location: CLLocation = CLLocation(latitude: latitude,
            //                                      longitude: longitude)
            //ADBMobile.trackLocation(location, data:tracklocationData as [AnyHashable: Any])
            
            /** PB, end in camp exercise push notifications with ACS **/

            let eventname = "dma:mob:loggedin"
            let analyticsData: [String:String] = [
                "pagename":"\(eventname)",
                "device":"mobile",
                "category":"login",
                "crm_id" : "\(crm_id)",
                "authstate": "\(authstate)",
                "e_loggedin": "1"
                ]
            ADBMobile.trackAction(eventname, data:analyticsData as [AnyHashable: Any])
            
            let collectPIIData: [String:String] = [
                "authstate":"Logged In",
                "marketingCloudId":(ADBMobile.visitorMarketingCloudID()!),
                "externalId":(UserModel.getInstance().crm_id),
                "registrationToken":(appDelegate.pushidentifier),
                "userKey": "man"
            ]
            ADBMobile.collectPII(collectPIIData as [String : String])
            
        }
        else{
            LoggerModel.getInstance().log("login unsuccessful")
            authStateLabel.text = "Computer says no, please try again"
        }
    }
    
    @IBAction func logButtonPressed(_ sender: UIButton) {
    }
    
    
}
