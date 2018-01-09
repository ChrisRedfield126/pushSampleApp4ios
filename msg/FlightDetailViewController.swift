//
//  ProductDetailViewController.swift
//  wesbites
//
//  Created by Wessel Heringa on 2016
//  Copyright © 2016 Wessel Heringa. All rights reserved.
//

import UIKit

class FlightDetailViewController: UIViewController {
    

    /****commented this out for Exercise 2 ***/
    //let MBOXPROFILENAME="mobile-profile-mbox"
    
    var flight = FlightModel()
    
    @IBOutlet weak var buy_now_button: UIImageView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var from: UILabel!
    @IBOutlet weak var to: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var price: UILabel!
    
    
    /*** new code for Exercise 2****/
    fileprivate var ctaLink:String!
    fileprivate let TARGETDEFAULTCONTENT = "default"
    fileprivate let MBOXNAME = "dma-mobile-mbox-buynow"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /**
         * APPLICATION LOGIC
         *
         * Load the product and display on screen
         **/
        
        /****new code for Exercise 2****/
        buy_now_button.isHidden=true
        
        from.text = "From: \(flight.from)"
        to.text = "To: \(flight.to)"
        category.text = flight.category
        price.text = "Price: \(flight.price)"
        
        
        let url = URL(string: flight.thumbnailUrl)!
        //let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
        
        let data = try? Data(contentsOf: url)
        
        productImage.image = UIImage(data: data!)
        
        /**
         * ADOBE MOBILE SDK LOGIC
         *
         * Analytics call
         * (TODO) Target call: recommended products
         **/
        
        let crm_id = UserModel.getInstance().crm_id
        let authstate = UserModel.getInstance().authstate
        
        
        if(authstate=="Logged in"){
            let visitorIDs: [String:String] = ["'x_device_id":"\(crm_id)"]
            ADBMobile.visitorSyncIdentifiers(visitorIDs,authenticationState:ADBMobileVisitorAuthenticationState.authenticated)
        }
        
        
        let pagename = "dma:mob:flights:detail"
        let analyticsData: [String:String] = [
            "pagename":"\(pagename)",
            "channel" : "ecommerce",
            "device":"mobile",
            "category":"productfinder",
            "crm_id" : "\(crm_id)",
            "authstate": "\(authstate)",
            "flightfrom":"\(flight.from)",
            "flightto":"\(flight.to)",
            "flightcategory":"\(flight.category)",
            "e_product_view":"1"
        ]
        ADBMobile.trackState(pagename, data:analyticsData as [AnyHashable: Any])
        
        /**** Adjusted for Exercise 2******/
        // for now: use target to push mbox user profile. The 3rdpartyId will match with the desktop version
        var dictionaryTarget: [String : String] = Dictionary()
        //dictionaryTarget["profile.lastSeenCategory"] = product.category
        dictionaryTarget[ADBTargetParameterMbox3rdPartyId] = UserModel.getInstance().crm_id
        
        if(authstate=="Logged in"){
            // Removed: no longer needed with SDK 4.13.5
            //dictionaryTarget["vst.x_device_id.id"] = UserModel.getInstance().crm_id
            //dictionaryTarget["vst.x_device_id.authState"] = "1"
        }
        
        let request = ADBMobile.targetCreateRequest(withName: self.MBOXNAME, defaultContent: "default content", parameters: dictionaryTarget)
        
        ADBMobile.targetLoad(request, callback: setBuyNowButtonResponse)
        
    }
    
    /****new code for Exercise 2****/
    
    fileprivate func setBuyNowButtonResponse(_ entry:String?) -> Void{
        let data = entry!
        if(data==self.TARGETDEFAULTCONTENT){
            LoggerModel.getInstance().log("Target response is nil; Internet down?")
            
        }
        else{
            DispatchQueue.main.async(execute: {
                // code here
                LoggerModel.getInstance().log("Target response: \(entry!)")
                
                if self.from.text!.range(of: "New York") != nil || self.to.text!.range(of: "New York") != nil {
                    if(data=="ny_travelers"){
                        self.buy_now_button.isHidden=false
                    }
                }
            })
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /****new code for exercise 2*****/
    
    
    
    
}
