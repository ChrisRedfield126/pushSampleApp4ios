//
//  ProductTableViewController.swift
//  wesbites
//
//  Created by Wessel Heringa on 13/12/15.
//  Copyright © 2015 Wessel Heringa. All rights reserved.
//

import UIKit
import Foundation


class DiscountViewController: UIViewController {
    
    @IBOutlet weak var targetLabel: UILabel!

    @IBOutlet weak var salesImage: UIImageView!
   
    @IBOutlet weak var salesTitle: UILabel!
    @IBOutlet weak var salesCTA: UIButton!
    @IBOutlet weak var salesSubtitle: UILabel!
    
    
    fileprivate var ctaLink:String!
    fileprivate let TARGETDEFAULTCONTENT = "default"
    fileprivate let MBOXNAME = "dma-mobile-mbox"

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /** Application logic
         *
         *
         * (set default sales banner)
         **/
         setDefaultSales()
         
        
        
        
        /** Adobe Mobile SDK logic
         *
         * Set Analytics variable
         **/
        
        let crm_id = UserModel.getInstance().crm_id
        let authstate = UserModel.getInstance().authstate
        LoggerModel.getInstance().log(authstate)
        
        if(authstate=="Logged in"){
            let visitorIDs: [String:String] = ["'x_device_id":"\(crm_id)"]
            ADBMobile.visitorSyncIdentifiers(visitorIDs,authenticationState:ADBMobileVisitorAuthenticationState.authenticated)
        }
    

        /**
         * Analytics code here
         **/
        let pagename = "dma:mob:discount"
        let analyticsData: [String:String] = [
            "pagename":"\(pagename)",
            "device":"mobile",
            "category":"sales",
            "crm_id" : "\(crm_id)",
            "authstate": "\(authstate)",
            "e_ad_impression": "1"
        ]
        ADBMobile.trackState(pagename, data:analyticsData as [AnyHashable: Any])
        
        
        /**
         * Adobe Target code
         *
         * https://marketing.adobe.com/resources/help/en_US/mobile/ios/c_target_methods.html
         *
         **/

        /**
         * Bucket of additional parameters send to Target
         * Use this e.g. for sending info to recommendations
         **/
        var dictionary: [String : String] = Dictionary()
        dictionary["anmboxparameter"] = "something"
        dictionary["anothermboxparameter"] = "somethingelse"
        
        let request = ADBMobile.targetCreateRequest(
            withName: "dma-mobile-mbox",
            defaultContent: "default-content",
            parameters: dictionary)
        
        ADBMobile.targetLoad(request, callback: setSalesFromAdobeTargetResponse)
    }
    
    fileprivate func setSalesFromAdobeTargetResponse(_ entry:String?) -> Void{
        let data = entry!
        if(data==self.TARGETDEFAULTCONTENT){
            LoggerModel.getInstance().log("Target response is nil; Internet down?")
            
        }
        else{
            DispatchQueue.main.async(execute: {
                // code here
                LoggerModel.getInstance().log("Target response: \(entry!)")
                
                if(entry=="default-content"){
                    self.setDefaultSales()
                }
                else{
                    let dataFromEntry = entry!.data(using: String.Encoding.utf8, allowLossyConversion: false)
                    
                    //let data = JSON(data:dataFromEntry!)
                    let data = try? JSONSerialization.jsonObject(with: dataFromEntry!, options: []) as! NSDictionary
                    
                    let image = data?["image"] as! String
                    let title = data?["title"] as! String
                    let subtitle = data?["subtitle"] as! String
                    let ctatext = data?["ctatext"] as! String
                    let ctalink = data?["ctalink"] as! String
                    self.setSales(image,title:title,subTitle:subtitle, ctaLink:ctalink, ctaText: ctatext)
                }
                
            })
        //ADBMobile.visitorSyncIdentifiers(<#T##identifiers: [NSObject : AnyObject]?##[NSObject : AnyObject]?#>, authenticationState: <#T##ADBMobileVisitorAuthenticationState#>)
        }
    }


    fileprivate func setDefaultSales(){
        let image = "https://wesbites.com/msg/resources/msg_logo.png";
        let title = "Title"
        let subTitle = "SubTitle"
        let ctaLink = "https://www.google.com"
        let ctaText = "Google is your friend"
        setSales(image,title:title,subTitle: subTitle,ctaLink: ctaLink,ctaText: ctaText)
    }
    
    fileprivate func setSales(_ imageUrl:String,title:String,subTitle:String,ctaLink:String,ctaText:String){
        
        salesTitle.text = title
        salesSubtitle.text = subTitle
        self.salesCTA.setTitle(ctaText,for:UIControlState())
        self.ctaLink = ctaLink
        
        if let url = URL(string: imageUrl){
            DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async(execute: {self.salesImage.image = UIImage(data: data)})
                }
            }
        }
        
    }
    
    
    @IBAction func ctaButtonClicked(_ sender: UIButton) {
            print("cta button clicked")
    }
}
