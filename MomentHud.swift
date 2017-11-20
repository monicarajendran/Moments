//
//  MomentHud.swift
//  Moments
//
//  Created by user on 17/11/17.
//  Copyright © 2017 user. All rights reserved.
//

import Foundation
import MBProgressHUD

class MomentHud{
    
    static func showHUD(vc: UIView) -> MBProgressHUD {
        
            let hud = MBProgressHUD.showAdded(to: vc, animated: true)
            
            hud.mode = .text
            
            hud.progress = 1
            
            hud.contentColor = UIColor.white
        
            hud.label.sizeToFit()
            
            hud.label.font = UIFont(name: "HelveticaNeue", size: 15)
            
            hud.bezelView.color = UIColor.black
        
            return hud

    }
   
}
