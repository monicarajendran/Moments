//
//  App Extension.swift
//  Moments
//
//  Created by Monica on 03/04/18.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation
import UIKit

extension Int64 {
    
    var toDate: Date {
        return Date(timeIntervalSince1970: TimeInterval(self))
    }
}
