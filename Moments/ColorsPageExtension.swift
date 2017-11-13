//
//  ColorsPageExtension.swift
//  Moments
//
//  Created by user on 02/11/17.
//  Copyright © 2017 user. All rights reserved.
//

import Foundation

import UIKit

extension ColorsViewController {
    
//    func themeColors(label: UILabel){
//        
//            label.backgroundColor = UIColor(hexString: MomentColors.allCases[].rawValue)
//    }
    
    func circleShapeForLabel(label: UILabel){
        
        label.layer.cornerRadius = label.frame.size.width / 2
    }
    
}
