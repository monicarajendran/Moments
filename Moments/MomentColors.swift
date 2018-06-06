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
    
    case blue = "039BE5"
    case brown = "E26367"
    case pink = "EC407A"
    case indigo = "5C6BC0"
    case teal = "4DB6AC"
    case cyan = "00ACC1"
    case pestoGreen = "00AA8D"
    case purple = "AB47BC"
    case lightGreen = "ABB64C"
    case gray = "607D8B"
    
    //Passcode
    case red = "E73F39"
    case green = "32D375"
    
    var name: String {
       return  String(describing: self).capitalized
    }
    
    static let allCases = [blue,brown,pink,indigo,teal,cyan,pestoGreen,purple,lightGreen,gray]
}
