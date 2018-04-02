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
import FullFeedback

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
    
    func feedback(){
        
        let loopTodoKey = "agtzfmxvb3BhYmFja3IRCxIETG9vcBiAgKCBz82QCgw"
        
        guard let feedbackvc = FeedbackViewController.initialize(loopToDoKey: loopTodoKey, feedbackCardTitle: "FullMomentsFeedback") else {
            return
        }
        //custom color
        //        feedbackvc.navBarColor = UIColor(red: 229/255, green: 84/255, blue: 114/255, alpha: 1.0)
        //        feedbackvc.segmentControlTintColor = UIColor(red: 229/255, green: 84/255, blue: 114/255, alpha: 1.0)
        feedbackvc.statusBarStyle = .lightContent
        
        feedbackvc.leftButtonImage = #imageLiteral(resourceName: "backButton")
        
        //additonal
        //feedbackvc.deviceInfo = ["deviceTest": "Testing"]
        
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? ""

        feedbackvc.appInfo = ["appName": "FullMoments", "appVersion": appVersion]
        
        self.present(feedbackvc, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch (indexPath.section, indexPath.row) {
        
        //feedback
        case (0,0):
        
            feedback()
            
        //passcode
        case (1,0) :
            
            guard let passcodeSettingsVc = storyboard?.instantiateViewController(withIdentifier: "PasscodeSettingsViewController") else { return }
            navigationController?.pushViewController(passcodeSettingsVc, animated: true)
            
        default:
            break
            
        }
    }
}


