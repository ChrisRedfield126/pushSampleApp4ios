//
//  ProductTableViewCell.swift
//  wesbites
//
//  Created by Wessel Heringa on 13/12/15.
//  Copyright © 2015 Wessel Heringa. All rights reserved.
//

import UIKit


/**
 * Helper Class.
 * Are you an MSA working on the Challenge pack? Then this code is not important for you.
 **/
class UIProductTableViewCell: UITableViewCell {

    
    static let reuseIdentifier: String = "UIProductTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        //print("selected this cell")
    }

    @IBOutlet weak var titleLabel: UILabel!
    
    
    
}
