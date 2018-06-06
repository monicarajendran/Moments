//
//  TimeLineNavigationController.swift
//  Moments
//
//  Created by Karthik on 4/14/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class TimeLineNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //[self.navigationController.interactivePopGestureRecognizer setDelegate:nil];
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


class DetailsNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //[self.navigationController.interactivePopGestureRecognizer setDelegate:nil];
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
