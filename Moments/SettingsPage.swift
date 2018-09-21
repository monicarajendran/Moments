//
//  SettingsPage.swift
//  Moments
//
//  Created by user on 18/07/1939 Saka.
//  Copyright © 1939 Saka user. All rights reserved.
//

import UIKit
import AlecrimCoreData
import CoreData
import CloudKit
import FullFeedback

class SettingsPage: UITableViewController {
    
    @IBOutlet weak var labelVersion: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelVersion.text = Utils.getAppVersion()
    }

    override func viewWillAppear(_ animated: Bool) {
        
        UIApplication.shared.statusBarStyle = .lightContent
        self.navigationController?.navigationBar.topItem?.title = "Settings"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch (indexPath.section, indexPath.row) {
        
        //feedback
        case (0,0):
            guard let feedbackvc = FeedbackViewController.initialize(loopToDoKey: "agtzfmxvb3BhYmFja3IRCxIETG9vcBiAgKCBz82QCgw", feedbackCardTitle: "IOS Full Moments Feedback") else {
                return
            }
            
            let themeColour = UIColor(hexString: "ee5353")
            feedbackvc.navBarColor = themeColour
            feedbackvc.statusBarStyle = .lightContent
            feedbackvc.titleColor = UIColor.white
            feedbackvc.segmentControlTintColor = themeColour
            feedbackvc.appInfo = ["App Version": Utils.getAppVersion()]
            
            self.present(feedbackvc, animated: true, completion: nil)
        
        //passcode
        case (1,0) :
            
            guard let passcodeSettingsVc = storyboard?.instantiateViewController(withIdentifier: "PasscodeSettingsViewController") else { return }
            navigationController?.pushViewController(passcodeSettingsVc, animated: true)
            
        default:
            break
            
        }
    }
}


