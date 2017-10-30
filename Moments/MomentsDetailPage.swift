//
//  MomentsDetailPage.swift
//  Moments
//
//  Created by user on 29/07/1939 Saka.
//  Copyright © 1939 Saka user. All rights reserved.
//

import UIKit

class MomentsDetailPage: UIViewController {
    
    @IBOutlet weak var nameOfTheMoment: UILabel!
    @IBOutlet weak var dateOfTheMoment: UILabel!
    @IBOutlet weak var descriptionOfTheMoment: UITextView!
    
    var momentNameFromDb = String()
    var momentDateFromDb = String()
    var momentDescriptionFromDb = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = UIColor.white
        
        tabBarController?.tabBar.isHidden = true
        navigationItem.title = momentNameFromDb
        nameOfTheMoment.text = momentNameFromDb
        dateOfTheMoment.text = momentDateFromDb
        descriptionOfTheMoment.text = momentDescriptionFromDb

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
   


}
