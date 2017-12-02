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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        activityIndicator.startAnimating()
        navigationController?.setNavigationBarHidden(true, animated: false)
     
        fetchICloudRecord()
        
    }
    
    
    func fetchICloudRecord(){
        
        CloudSyncServices.fetchAllMomentsWithCursor(batch: { (bathMomentRec , error) in
            if error == nil {
            print(bathMomentRec)
            
            for momentRec in bathMomentRec {
  
                let momentObj = container.viewContext.moment.create()
                
              let _ = momentObj.fromICloudRecordToMoment(record: momentRec)
                
            do {
                
                try container.viewContext.save()
            }
            catch {
                print("Error in saving iCloud moment into coredata")
                }
            }
        }
         else {
                let alert = UIAlertController(title: "Error", message: "Sign In iCloud", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            }
        },
        completion: { moment in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1 , execute: {
                guard let tabBar = self.storyboard?.instantiateViewController(withIdentifier: "TabBar") else {
                    return }
                self.navigationController?.pushViewController(tabBar, animated: false)
            })
        })
    }
}
