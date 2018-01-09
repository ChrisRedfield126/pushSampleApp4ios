//
//  ProductTableViewController.swift
//  wesbites
//
//  Created by Wessel Heringa on 13/12/15.
//  Copyright © 2015 Wessel Heringa. All rights reserved.
//

import UIKit
import CoreLocation


class HomeTableViewController: UITableViewController {
    
    
    @IBOutlet weak var myAccountLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        super.viewWillAppear(animated)
        
        /** Application logic
         *
         *
         * Set authentication state in 'my account' label
        **/
        let authstate = UserModel.getInstance().authstate
        myAccountLabel.text="My account ( \(authstate) )"
        
        
        /** Adobe Mobile SDK logic
         *
         * Set Analytics variable
        **/
        
        let crm_id = UserModel.getInstance().crm_id
        
        if(authstate=="Logged in"){
            let visitorIDs: [String:String] = ["'x_device_id":"\(crm_id)"]
            ADBMobile.visitorSyncIdentifiers(visitorIDs,authenticationState:ADBMobileVisitorAuthenticationState.authenticated)
        }
        
        
        let pagename = "dma:mob:home"
        let analyticsData: [String:String] = [
            "pagename":"\(pagename)",
            "device":"mobile",
            "category":"home",
            "crm_id" : "\(crm_id)",
            "authstate": "\(authstate)",
        ]
        ADBMobile.trackState(pagename, data:analyticsData as [AnyHashable: Any])
        
    }
}
