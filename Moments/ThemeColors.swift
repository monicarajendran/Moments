//
//  Button.swift
//  Moments
//
//  Created by user on 30/10/17.
//  Copyright © 2017 user. All rights reserved.
//

import Foundation
import  UIKit

extension NewMomentsPageViewController {
    
   static func hexaStringColor(index: Int) -> String{
        
        var hexaColor = ""
        
        switch index {
            
        case 0:
            hexaColor = "#E73F39"
        case 1:
            hexaColor = "#039BE5"
        case 2:
            hexaColor = "#EC407A"
        case 3:
            hexaColor = "#5C6BC0"
        case 4:
            hexaColor = "#4DB6AC"
        case 5:
            hexaColor = "#00ACC1"
        case 6:
            hexaColor = "#00AA8D"
        case 7:
            hexaColor = "#AB47BC"
        case 8:
            hexaColor = "#AFB42B"
        case 9:
            hexaColor = "#EF6C00"
        case 10:
            hexaColor = "#AEAEAE"
        default:
            print("None")
        }
        
     return hexaColor
        
    }
    
    
    
}

// this will return UIColor
extension UIColor{
    
    convenience init(hexString: String) {
        
        let hexString: String = (hexString as NSString).trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner          = Scanner(string: hexString as String)
        
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }

}

   
    

