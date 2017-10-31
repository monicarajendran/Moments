//
//  Textfield.swift
//  Moments
//
//  Created by user on 30/10/17.
//  Copyright © 2017 user. All rights reserved.
//
import Foundation
import  UIKit

extension AddMomentsPage  {
   
    func momentNameCus(){
       
        momentName.becomeFirstResponder()
        
        momentName.autocapitalizationType = .sentences
        
        let border = CALayer()
        
        let width = CGFloat(1.0)
        
        border.borderWidth = width

        border.borderColor = UIColor.lightGray.cgColor
        
        border.frame = CGRect(x: 0, y: momentName.frame.size.height - width, width:  momentName.frame.size.width, height: momentName.frame.size.height)
        
        momentName.layer.addSublayer(border)
        
        momentName.layer.masksToBounds = true
        
        
    }
    
}

