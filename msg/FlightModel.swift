//
//  Product.swift
//  wesbites
//
//  Created by Wessel Heringa on 12/12/15.
//  Copyright © 2015 Wessel Heringa. All rights reserved.
//

import Foundation

/**
 * This class handles the flights; it fetches them from a remote server and packages them in a format the controller can read
 * Are you an MSA working on the Challenge pack? Then this code is not important for you.
 **/
class FlightModel:CustomStringConvertible{
    
    fileprivate var data:[String:String]
    static let endpoint = URL(string: "https://wesbites.com/msg/flights.php")!
    fileprivate let BASEIMAGEURL = "https://wesbites.com/"
    
    
    var id: String{
        get{
            return data["flightid"]!
        }
    }
    
    var shortdescription:String{
        get{
            return data["shortdescription"]!
        }
    }
    
    var category:String{
        get{
            return data["category"]!
        }
    }
    
    var from: String{
        get{
            return data["flightfrom"]!
        }
    }
    
    var to: String{
        get{
            return data["flightto"]!
        }
    }
    
    var price: String{
        get{
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.locale=Locale(identifier: "nl_NL")
            let price_s = data["price"]
            
            if let price_i = Int(price_s!) {
                let price_n = NSNumber(value: price_i)
                let price_f = formatter.string(from:price_n)
                return price_f! as String!
            }
            else{
                return "error"
            }
        }
    }
    
    public var description: String {
        return "FlightModel: from: \(self.from) \n to: \(self.to) \n thumbNailUrl: \(self.thumbnailUrl)"
    }

    
    var thumbnailUrl:String{
        get{
            return "\(self.BASEIMAGEURL)\(data["thumbnailUrl"]!)"
        }
    }
    
    
    fileprivate init(data: [String:String]){
        self.data = data
    }
    
    // ugly hack!
    init(){
        let data:[String:String] = ["nothing":"nothing"]
        self.data=data
    }
    
    
    static func getFlights() -> ([String:FlightModel]?){
        
        if(Reachability.isCRMAccessible()){
            let data = try? Data(contentsOf: endpoint)
            if(data==nil){
                print("Unable to get contents from CRM url endpoint. Endpoint down?")
                return nil
            }
            let json = try? JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
            var flights = [String:FlightModel]()
            for (item) in json! {
                let f = FlightModel.init(data: item as! [String:String])
                flights[f.id] = f
                print(f)
            }
            return flights
        }
        else{
            print("Internet is Down!")
            return nil
        }
    }
    
}
