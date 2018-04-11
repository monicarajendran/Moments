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

class SettingsPage: UITableViewController {
    
    @IBOutlet weak var labelVersion: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String , let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String else { return }
        labelVersion.text = "\(version)(\(build))"
    }

    override func viewWillAppear(_ animated: Bool) {
        
        UIApplication.shared.statusBarStyle = .default
        self.navigationController?.navigationBar.topItem?.title = "Settings"
    }
    
    @IBAction func deleteAllMoments(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Would you like to delete all Moments", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            self.deleteAll() }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func deleteAll () {
        
        let moments = container.viewContext.moment
        
        for moment in moments {
            
            let recordId = CKRecordID(recordName: moment.momentID)
            CloudSyncServices.privateDb.delete(withRecordID: recordId) { (recordId, err) in
                if err == nil {
                    print("Moment is deleted in iCloud, id:", recordId)
                } else {
                    print("Error occured in deleting moment in icloud", err)
                }
            }
        }
        
        moments.deleteAll()
        do {
            try container.viewContext.save()
        } catch {
            print("Error in deleting the moments")
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch (indexPath.section, indexPath.row) {
        
        //feedback
        case (0,0):
            
            guard let feedBackPage = storyboard?.instantiateViewController(withIdentifier: "FeedBackViewController") else { return }
            navigationController?.pushViewController(feedBackPage, animated: true)
        
        //passcode
        case (1,0) :
            
            guard let passcodeSettingsVc = storyboard?.instantiateViewController(withIdentifier: "PasscodeSettingsViewController") else { return }
            navigationController?.pushViewController(passcodeSettingsVc, animated: true)
            
        default:
            break
            
        }
    }
}


