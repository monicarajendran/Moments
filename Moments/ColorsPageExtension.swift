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
    
    func themeColors(){
       
        red.backgroundColor = MomentColors.red.uicolor()
        blue.backgroundColor = MomentColors.blue.uicolor()
        pink.backgroundColor = MomentColors.pink.uicolor()
        indigo.backgroundColor = MomentColors.indigo.uicolor()
        teal.backgroundColor = MomentColors.teal.uicolor()
        cyan.backgroundColor = MomentColors.cyan.uicolor()
        pestoGreen.backgroundColor = MomentColors.pestoGreen.uicolor()
        purple.backgroundColor = MomentColors.purple.uicolor()
        lime.backgroundColor = MomentColors.lime.uicolor()
        orange.backgroundColor = MomentColors.orange.uicolor()
        gray.backgroundColor = MomentColors.gray.uicolor()
        
    }
    
    func circleShapeForLabel(label: UILabel){
        
        label.layer.cornerRadius = label.frame.size.width / 2
    }
    
}
