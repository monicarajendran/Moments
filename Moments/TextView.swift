//
//  TextView.swift
//  Moments
//
//  Created by user on 30/10/17.
//  Copyright © 2017 user. All rights reserved.
//

import Foundation
import UIKit

extension AddMomentsPage {
    
    func momentDescriptionCus(){
        
    momentDescription.delegate = self
    momentDescription.textColor = .lightGray
    momentDescription.text = "Describe the Moment.."
    momentDescription.layer.cornerRadius = 5
    momentDescription.layer.borderWidth = 0.1
        
    momentDescription.layer.borderColor = UIColor.black.cgColor

    
    }
    
}
