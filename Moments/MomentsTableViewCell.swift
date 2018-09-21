//
//  MomentsTableViewCell.swift
//  Moments
//
//  Created by user on 03/11/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit

class MomentsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var day: UILabel! {
        didSet {
            day.font = AppFont.bold(size: 15)
        }
    }
    
    @IBOutlet weak var date: UILabel! {
        didSet {
            date.font = AppFont.bold(size: 29)
        }
    }
    
    @IBOutlet weak var momentName: UILabel! {
        didSet {
            momentName.font = AppFont.medium(size: 16)
        }
    }
    
    @IBOutlet weak var momentDescription: UILabel! {
        didSet {
            momentDescription.font = AppFont.medium(size: 14)
        }
    }
    
    @IBOutlet weak var viewForCell: UIView!
    
    @IBOutlet weak var viewForDate: UIView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
