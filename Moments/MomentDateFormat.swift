//
//  MomentDateFormat.swift
//  Moments
//
//  Created by user on 17/11/17.
//  Copyright © 2017 user. All rights reserved.
//

import Foundation

enum MomentDateFormat : String{
    
    case day = "EEE"
    case year = "yyyy"
    case month = "MMM"
    case week = "dd - dd"
    case date = "dd"
    case short = "dd MMM yyyy"
    case dayMonthYear = "dd MMMM yyyy"
    case monthYear = "MMMM yyyy"
    case long = "EEE dd MMM yy"
    case `default` = "yyyy-MM-dd HH:mm:ss ZZZZ"
    
}
