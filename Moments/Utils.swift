//
//  Utils.swift
//  Moments
//
//  Created by Monica on 21/09/18.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation

class Utils {
    
    static func getAppVersion () -> String {
    
        guard let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String , let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String else {
            return ""
        }
        return version + "(\(build))"
    }
    
}
