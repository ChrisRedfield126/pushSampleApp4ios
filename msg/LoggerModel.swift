//
//  LoggerModel.swift
//  wesbites
//
//  Created by Wessel Heringa on 28/01/16.
//  Copyright © 2016 Wessel Heringa. All rights reserved.
//

import Foundation


/**
 * Singleton instance for logging purposes.
 * Are you an MSA working on the Challenge pack? Then this code is not important for you.
 **/
class LoggerModel{


    static fileprivate let singleton = LoggerModel()
    fileprivate var logs:[String]
    
    static func getInstance() -> LoggerModel{
        return singleton
    }
    
    fileprivate init(){
        logs = [String]()
    }
    
    func log(_ message:String){
        print("MSG Mobile Demo APP: \(message)")
        logs.append(message)
    }
    
    func getMessages()->[String]{
        return logs
    }

}
