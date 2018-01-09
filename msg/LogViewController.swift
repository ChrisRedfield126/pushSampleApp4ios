//
//  LogViewController.swift
//  wesbites
//
//  Created by Wessel Heringa on 28/01/16.
//  Copyright © 2016 Wessel Heringa. All rights reserved.
//

import Foundation
import UIKit

class LogViewController: UIViewController {

    override func viewDidLoad() {
        
        let logs = LoggerModel.getInstance().getMessages()
        
        var message = ""
        for item in logs {
            message += "\n" +
                    "[ \(item) ] "
        }
        logLabel.text = message
        
        super.viewDidLoad()
        
       // ADBMobile.trackState("mobile:log:view",data:nil)

    }
    
    
    @IBOutlet weak var logLabel: UILabel!
    
    
}