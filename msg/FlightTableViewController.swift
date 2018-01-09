//
//  ProductTableViewController.swift
//  wesbites
//
//  Created by Wessel Heringa on 13/12/15.
//  Copyright © 2015 Wessel Heringa. All rights reserved.
//

import UIKit

class FlightTableViewController: UITableViewController {
    var flights = [FlightModel]()
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            
        
        /** Application logic
         *
         *
         *
         **/
        
        loadFlights()
        
        /** Adobe Mobile SDK logic
         *
         * Set Analytics variable
         **/
        
        let crm_id = UserModel.getInstance().crm_id
        let authstate = UserModel.getInstance().authstate
        
        
        if(authstate=="Logged in"){
            let visitorIDs: [String:String] = ["'x_device_id":"\(crm_id)"]
            ADBMobile.visitorSyncIdentifiers(visitorIDs,authenticationState:ADBMobileVisitorAuthenticationState.authenticated)
        }
        
       /**
        * Analytics code here
        **/
        let pagename = "dma:mob:flights:lister"
        let analyticsData: [String:String] = [
            "pagename":"\(pagename)",
            "device":"mobile",
            "category":"productfinder",
            "crm_id" : "\(crm_id)",
            "authstate": "\(authstate)",
            "e_product_lister_view": "1"
        ]
        ADBMobile.trackState(pagename, data:analyticsData as [AnyHashable: Any])
        
        
    }
    
    
    /**
     * APPLICATION LOGIC that fetches the products from a remote url and writes them in the table
     *
     *
     **/
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flights.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Our top flights" // Section \(section)"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell( withIdentifier: "ProtoCell", for: indexPath)
        
        cell.textLabel?.text = flights[(indexPath as NSIndexPath).row].shortdescription
        cell.detailTextLabel?.text = flights[(indexPath as NSIndexPath).row].price
        
        return cell
    }
    
    func loadFlights(){
        let psDict = FlightModel.getFlights()
        if(psDict==nil){
            //assert(false,"No products found, network error?")
            LoggerModel.getInstance().log(("Didn't find any flights, internet down?"))
        }
        else{
            let fl = Array(psDict!.values)
            flights = fl
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        //print("preparing for segue: \(segue.identifier)")
        if (segue.identifier == "flight_detail_segue") {
            let svc = segue.destination as! FlightDetailViewController
            let selectedIndex = self.tableView.indexPath(for: sender as! UITableViewCell)!
            svc.flight = flights[(selectedIndex as NSIndexPath).row]
        }
        else{
            //print("seque not found")
        }
    }
    
    
    /**
     * /END APPLICATION LOGIC
     *
     *
     **/
    
}
