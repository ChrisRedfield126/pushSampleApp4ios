//
//  NewsViewController.swift
//  msg
//
//  Created by Wessel Heringa on 14/05/16.
//  Copyright © 2016 Wessel Heringa. All rights reserved.
//
import Foundation

import UIKit

class NewsViewController: UIViewController {
    
    @IBOutlet weak var LogLabel: UILabel!

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        /**
         * This screen loads a webview, a html page within the app
         *
         *
         **/
        
        /**
         * The URL to load
         **/
        let webViewUrl = URL (string:"http://christopheprotat.com/news/news-lister.html")
        
        
        /**
         * Now to send acros the visitor identifier to this html page. 
         * Then on this HTML page we have DTM installed that uses this identifier
         * This way we can track the user's behaviour through the app and the webview
         * Do not use this in combination with "offlineEnabled": set to 'true' as it will 
         *       lead to inconsistent tracking for visitors that temporarily do not have internet access
         **/
        
        /**
         * From SDK 4.12.0: Use the baked-in API call
         * Use in combination with Marketing Cloud ID service 1.7.0 deployed to the webview page
         **/
        
        let webViewUrlWithVisitorID = ADBMobile.visitorAppend(to: webViewUrl)

        /**
         * For versions before SDK 4.12.0 and pre MArketing Cloud ID service 1.7.0, the visitorAppendToUrl method is not available
         * So you need to manually insert this, see the following section
         **/
        
        
            /**
             * Option #1 of visitorID: use marketing Cloud ID service
             **/
            
            //var marketingID = ADBMobile.visitorMarketingCloudID()
            //if(marketingID==nil){
            //   LoggerModel.getInstance().log("Marketing Cloud ID returned nil; Check your ADBMobileConfig.json or provisioning status")
            //    marketingID="nil"
            // }
            
            /**
             * Option #2 of visitorID: use the old identifier or the fallback identifier
             **/

            //var visitorID = ADBMobile.userIdentifier()
            //if(visitorID==nil){
            //  visitorID=ADBMobile.trackingIdentifier()
            //}
            //if(visitorID==nil){
            //    print("ERROR: visitorID is nil, can't send to webview!")
            //    visitorID="nil"
            //}
            //let webViewUrlWithVisitorID = NSURL(string:"https://wesbites.com/msg/news.html?appvi=\(visitorID!)")

             
        /**
         * Either way, at this point webViewUrlWithVisitorID now contains the url of the webview including the ID of the visitor
         * Now load the webview
         **/
        
        
        //LoggerModel.getInstance().log("Connecting to webview URL: \(webViewUrlWithVisitorID)")
        
        let requestObj = URLRequest(url: webViewUrlWithVisitorID!);
        //let requestObj = NSURLRequest(URL: webViewUrl!);
        
        webView.loadRequest(requestObj);
        
        
        /** Adobe Mobile SDK logic
         *
         *
         *
         * Set Analytics variable
         **/
        
        let crm_id = UserModel.getInstance().crm_id
        let authstate = UserModel.getInstance().authstate
        
        
        if(authstate=="Logged in"){
            let visitorIDs: [String:String] = ["'x_device_id":"\(crm_id)"]
            ADBMobile.visitorSyncIdentifiers(visitorIDs,authenticationState:ADBMobileVisitorAuthenticationState.authenticated)
        }
        
        let pagename = "dma:mob:news"
        let analyticsData: [String:String] = [
            "pagename":"\(pagename)",
            "device":"mobile",
            "category":"home",
            "crm_id" : "\(crm_id)",
            "authstate": "\(authstate)"
            ]
        ADBMobile.trackState(pagename, data:analyticsData as [AnyHashable: Any])
        
        
    }
}


