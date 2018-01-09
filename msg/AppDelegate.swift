//
//  AppDelegate.swift
//  wesbites
//
//  Created by Wessel Heringa on 11/12/15.
//  Copyright © 2015 Wessel Heringa. All rights reserved.
//

import UIKit
import Foundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    /** PB, begin set pushidentifier variable to be used in another controller and function to convert token into string **/
    var pushidentifier: String = ""
    func tokenString(_ deviceToken:Data) -> String{
        //code to make a token string
        let bytes = [UInt8](deviceToken)
        var token = ""
        for byte in bytes{
            token += String(format: "%02x",byte)
        }
        return token
    }
    /** PB, begin set pushidentifier variable to be used in another controller and function to convert token into string **/


    /**
     * Called when application starts
     **/
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        
        /**
         * Set the debugging for the Mobile Core Services.
         **/
        //ADBMobile.setDebugLogging(true)

        /* Log the customer out */
        //let visitorIDs: [String:String] = ["'x_device_id":""]
        //ADBMobile.visitorSyncIdentifiers(visitorIDs,authenticationState:ADBMobileVisitorAuthenticationState.loggedOut)
        
        
        /**
         * Allow for push messages (popup on first launch asking for push message permissions)
         **/
        let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
        application.registerUserNotificationSettings(settings)
        application.registerForRemoteNotifications()
        
        /*
         * Set Lifecycledata collecting
         **/
        ADBMobile.collectLifecycleData()

        /**
         * Additional debug messages. 
         * Expected: No Audience Manager UUID, as we use server side forwarding with the Marketing Cloud ID
         **/
        //if let uuid = ADBMobile.audienceDpuuid(){LoggerModel.getInstance().log("Your Audience Manager UUID is: \(uuid)")}
        //else{LoggerModel.getInstance().log("You don't have an AAM UUID. That's OK as we use the Marketing Cloud ID")}
        if let mid = ADBMobile.visitorMarketingCloudID() {LoggerModel.getInstance().log("Your marketing cloud ID is: \(mid)")}
        else{LoggerModel.getInstance().log("Check your ADBMobile.json; you don't have a Marketing Cloud ID")}
        
        return true
    }

    func application(_ application: UIApplication,didFailToRegisterForRemoteNotificationsWithError error: Error){
        LoggerModel.getInstance().log("Cannot register for push message. Are you running on the simulator?")
        //print("Failed to register for push messages:'\(error)' ") // use this line for extensive debugging
        
        
    }

    
    /**
     * Called when a remote notification is received
     * This can be both push messages and in-app messages
     * And they can come from Campaign or the Mobile SDK (or any other push message service configured)
     * 
     * The userInfo object contains the actual message
     **/
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        
        /**
         * TODO Distinguish between Campagin and Mobile SDK - HOW?
         * TODO Do something with additional send from Mobile SDK
         * TODO Track message received from Mobile SDK (using postback?)
         * TODO Handle Deeplinks
         **/
        LoggerModel.getInstance().log("userInfo: \(userInfo)")
        if let aps = userInfo["aps"] as? NSDictionary{
            if let alert = aps["alert"] as? NSDictionary
            {
                if let message = alert["message"] as? NSString
                {
                    LoggerModel.getInstance().log(message as String);
                }
            }
            else if let alert=aps["alert"] as? NSString
            {
                LoggerModel.getInstance().log(alert as String);
                let alert = UIAlertController(title: "Alert", message: alert as String, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
                self.window?.rootViewController?.present(alert, animated: true, completion: nil)
            }
            if  let b = aps["badge"] as? Int
            {
                
                application.applicationIconBadgeNumber = b;
            }
        }
        
        
        /* CPR : Tracking postack */
        /*if (application.applicationState != UIApplicationState.active) {
            
            let trackingData: [String:String] = [
                "pev2":"tracking",
                "broadlog":"_mId",
                "delivery":"_dId",
                "action": "1"
            ]
            ADBMobile.trackAction("tracking", data:trackingData as [AnyHashable: Any])
        }*/

        if application.applicationState != .active {
            ADBMobile.trackAction("tracking", data: ["deliveryid": userInfo["_dId"], "broadlogid": userInfo["_mId"], "action": "1"])
        }

    }
    
    
    /**
     * Code to handle deep links
     **/
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb {
            let urlString: String = (userActivity.webpageURL?.path)!

            if urlString.range(of: "geolocation") != nil {
                let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let initialViewController : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "geolocation") as UIViewController
                self.window = UIWindow(frame: UIScreen.main.bounds)
                self.window?.rootViewController = initialViewController
                self.window?.makeKeyAndVisible()
            }
            else{
                let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let initialViewController : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "flights") as UIViewController
                self.window = UIWindow(frame: UIScreen.main.bounds)
                self.window?.rootViewController = initialViewController
                self.window?.makeKeyAndVisible()
            }

        }
        
        return true
    }

    
    /**
     * When user pressed 'yes I do' and accepted notifications. Additional call to registerForRemoteNotifications is (probably) needed for this first time
     **/
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
            // print("settings: \(notificationSettings)") // print to see notification types
            if notificationSettings.types != UIUserNotificationType() {
                application.registerForRemoteNotifications()
            }
    }
    
    /**
     * Called when registrering for remote notifications
     * For Campaign, 
     *   This is done when logging in
     *   We register with the DeviceTokenString, a unique string identifiying this device (and will be reset when uninstalling the app
     *   And we also send the e-mail address and device name
     **/
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        /*
        let characterSet: CharacterSet = CharacterSet(charactersIn: "<>")
        let deviceTokenString: String = (deviceToken.description as NSString)
            .trimmingCharacters(in: characterSet)
            .replacingOccurrences( of: " ", with: "") as String
        */
        
        /**  PB, begin set pushidentifier variable with deviceToken **/
        let deviceTokenString = tokenString(deviceToken)
        pushidentifier = deviceTokenString
        /**  PB, end set pushidentifier variable with deviceToken **/
        
        /**
         * Mobile SDK register
         **/
        
        ADBMobile.setPushIdentifier(deviceToken)
        
        /**
         * / Mobile SDK register
        **/
        
        
        LoggerModel.getInstance().log("Your device user ID to send push messages is: \(deviceTokenString)")
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

