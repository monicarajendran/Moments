//
//  SettingsPage.swift
//  Moments
//
//  Created by user on 18/07/1939 Saka.
//  Copyright © 1939 Saka user. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import AlecrimCoreData
import CoreData

class SettingsPage: UITableViewController {
    
    @IBOutlet weak var labelVersion: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String , let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String else { return }
        labelVersion.text = "\(version)(\(build))"
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.topItem?.title = "Settings"

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch (indexPath.section, indexPath.row) {
        case (0,0):
            
            guard let feedBackPage = storyboard?.instantiateViewController(withIdentifier: "FeedBackViewController") else { return }
            navigationController?.pushViewController(feedBackPage, animated: true)
            
        default:
            print("default case of settings")
        }
    }
}


