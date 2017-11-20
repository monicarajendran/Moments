//
//  LoadingViewController.swift
//  Moments
//
//  Created by user on 20/11/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit
import MBProgressHUD
import CloudKit

class LoadingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loadingHud = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingHud.mode = .indeterminate
        loadingHud.label.text = "Please wait"
        loadingHud.detailsLabel.text = "Loading"
        loadingHud.bezelView.backgroundColor = .black
        loadingHud.contentColor = .white
        
        // Do any additional setup after loading the view.
    }
    
    

}
