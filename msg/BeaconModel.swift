//
//  Beacon.swift
//  iBeaconTester
//
//  Created by Wessel Heringa on 28/08/16.
//  Copyright © 2016 Wessel Heringa. All rights reserved.
//

import Foundation

class BeaconModel {
    let name:String
    let UUID:Foundation.UUID
    let majorValue:NSNumber
    let minorValue:NSNumber
    
    
    init(name:String,uuid:Foundation.UUID,majorValue:NSNumber,minorValue:NSNumber){
        
        self.name = name
        self.UUID = uuid
        self.majorValue = majorValue
        self.minorValue = minorValue
    }
    
    func matches(_ uuid:Foundation.UUID,majorValue:NSNumber,minorValue:NSNumber) -> Bool{
        return (uuid==self.UUID && majorValue==self.majorValue && minorValue==self.minorValue)
    }
    
    
}
