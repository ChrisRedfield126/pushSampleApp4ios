//
//  UserModel.swift
//  wesbites
//
//  Created by Wessel Heringa on 12/12/15.
//  Copyright © 2016 Wessel Heringa. All rights reserved.
//

import Foundation


/**
 * This class handles the log in in the back end. Reaches out to a remote server
 * Are you an MSA working on the Challenge pack? Then this code is not important for you.
 **/
class UserModel{
    
    static let endpoint = URL(string: "https://wesbites.com/msg/?")!
    static let PASSWORDPARAM="password"
    static let USERPARAM="username"
    
    static fileprivate let singleton = UserModel()
    
    // singleton methods
    static func getInstance() -> UserModel{
        return singleton
    }
    
    var crm_id: String
    var authstate:String
    var username:String
    
    
    fileprivate init(){
        crm_id = ""
        authstate = "Not logged in"
        username = ""
    }
    
    
    
    
    func login(_ username:String,password:String) -> Bool{
        
        // CPR: authent bypassing
        self.crm_id = "\(username)"
        self.authstate = "Logged in"
        self.username = "\(username)"
        return true
        
        /*if(Reachability.isCRMAccessible()){
    
            let fullUrl = URL(string:"\(UserModel.endpoint)\(UserModel.USERPARAM)=\(username)&\(UserModel.PASSWORDPARAM)=\(password)")
            do{
                let str = try NSString(contentsOf: fullUrl!,encoding:String.Encoding.utf8.rawValue)
                if(str.hasPrefix("error")){
                    LoggerModel.getInstance().log("\(str)")
                    return false
                }
                
                
                self.crm_id = "\(str)"
                self.authstate = "Logged in"
                self.username = "\(username)"
                return true
            }catch{
                LoggerModel.getInstance().log("\(error)")
                return false
            }
        } // Reachability
        else{
            
            print("Internet is Down!")
            return false
            //return nil
        }*/
        
    }
    
    
}
