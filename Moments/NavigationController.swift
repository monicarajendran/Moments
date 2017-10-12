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
        
        
        if FBSDKAccessToken.current() == nil {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let homeViewController = mainStoryboard.instantiateViewController(withIdentifier:"LoginPage") as! LoginPage
            let rootView = UINavigationController(rootViewController: homeViewController)
            
            if let window = appDelegate.window {
                
                window.rootViewController = rootView
                
            }
            

            
            }
            
        }
        
    }
