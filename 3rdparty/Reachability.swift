/*
*/

import SystemConfiguration
import Foundation
import UIKit



/**
 * Check if the device has an internet connection
 * Are you an MSA working on the Challenge pack? Then this code is not important for you.
 **/
open class Reachability {
    /*
    
    From http://stackoverflow.com/questions/30743408/check-for-internet-connection-in-swift-2-ios-9

    */
    static func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            //SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
            
            
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
            
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
  
    /* 
        Later: Add more network checks
    */
    static func isCRMAccessible() -> Bool {
        if(Reachability.isConnectedToNetwork()){
            return true
        }
        else{
            print("Internet is down")
            return false
        }
        
    }
}
