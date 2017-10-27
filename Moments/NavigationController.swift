//
//  NavigationController.swift
//  Moments
//
//  Created by user on 20/07/1939 Saka.
//  Copyright © 1939 Saka user. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if FBSDKAccessToken.current() != nil {

            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            let homeViewController = storyboard?.instantiateViewController(withIdentifier:"TabBar") as! TabBar
            
            let rootView = UINavigationController(rootViewController: homeViewController)
            
            if let window = appDelegate.window {
                
                window.rootViewController = rootView
                
            }
            
        }
        
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }
    
}
