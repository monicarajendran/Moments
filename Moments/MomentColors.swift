//
//  enum.swift
//  Moments
//
//  Created by user on 07/11/17.
//  Copyright © 2017 user. All rights reserved.
//

import Foundation
import UIKit

enum MomentColors : String {
    
    case red = "E73F39"
    case blue = "039BE5"
    case pink = "EC407A"
    case indigo = "5C6BC0"
    case teal = "4DB6AC"
    case cyan = "00ACC1"
    case pestoGreen = "00AA8D"
    case purple = "AB47BC"
    case lime = "AFB42B"
    case orange = "EF6C00"
    case gray = "AEAEAE"
    
    static let allCases = [red,blue,pink,indigo,teal,cyan,pestoGreen,purple,lime,orange,gray]
    
    func uicolor() -> UIColor {
        
        var hexInt: UInt32 = 0

        let scanner: Scanner = Scanner(string: "\(rawValue)")

        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")

        scanner.scanHexInt32(&hexInt)
    
        let hexint = Int(hexInt)
        
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        let alpha = CGFloat(1.0)
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        
        return color
       
    }
    
}
