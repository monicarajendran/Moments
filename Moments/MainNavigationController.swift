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
            setRootviewController(indentifier: "LoadingViewController")
        }
        else if UserDefaults.standard.bool(forKey: "passcodeEnabled") {
            setRootviewController(indentifier: "LaunchViewController")
        }
        else{
            setRootviewController(indentifier: "TabBar")
        }
        
    }
    
    func setRootviewController(indentifier : String){
        
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let homeViewController = mainStoryboard.instantiateViewController(withIdentifier: indentifier)
            let rootView = UINavigationController(rootViewController: homeViewController)
            
            if let window = appDelegate.window {
                
                window.rootViewController = rootView
                
            }
    }
    
}

