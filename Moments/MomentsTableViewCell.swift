//
//  MomentsTableViewCell.swift
//  Moments
//
//  Created by user on 03/11/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit

class MomentsTableViewCell: UITableViewCell {
    

    @IBOutlet weak var day: UILabel!
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var momentName: UILabel!
    
    @IBOutlet weak var momentDescription: UILabel!
    
    @IBOutlet weak var viewForCell: UIView!
    
    @IBOutlet weak var viewForDate: UIView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
