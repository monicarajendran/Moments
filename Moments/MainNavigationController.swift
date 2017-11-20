//
//  MainNavigationController.swift
//  Moments
//
//  Created by user on 20/11/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit
import MBProgressHUD

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
                
        if UserDefaults.standard.bool(forKey: "first_run"){
            
            guard let momentsPage = storyboard?.instantiateViewController(withIdentifier: "MomentsTimeLinePage") else  { return }
            navigationController?.pushViewController(momentsPage, animated: true)

        }
        else{
            guard let loadPage = storyboard?.instantiateViewController(withIdentifier: "LoadingViewController") else  { return }
            navigationController?.pushViewController(loadPage, animated: true)

        }
        // Do any additional setup after loading the view.
    }

}
