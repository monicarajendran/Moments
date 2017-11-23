//
//  MainNavigationController.swift
//  Moments
//
//  Created by user on 21/11/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.bool(forKey: "firstRun") == false {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let homeViewController = mainStoryboard.instantiateViewController(withIdentifier:"LoadingViewController") as! LoadingViewController
            let rootView = UINavigationController(rootViewController: homeViewController)
            
            if let window = appDelegate.window {
                
                window.rootViewController = rootView
                
            }
        }
    }
}
