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
import AlecrimCoreData
import CoreData

class LoadingViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        navigationController?.setNavigationBarHidden(true, animated: false)
        activityIndicator.startAnimating()
        
        DispatchQueue.main.async {
             self.fetchICloudRecord()
        }
    }

    func fetchICloudRecord() {
        
        CloudSyncServices.fetchAllMomentsWithCursor(batch: { (bathMomentRec , error) in
           
            guard error == nil else {
                let alert = UIAlertController(title: "Error", message: "Sign In iCloud", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            let context = container.viewContext
            
            _ = bathMomentRec.compactMap({ rec in
                let momentObj = context.moment.create()
                
                let record = Record(record: rec)
                
                let moment_coredata = momentObj.fromICloudRecordToMoment(record: record) //setting
                
                print(moment_coredata)
            })
            
            context.perform {
                self.save(context: context)
            }
            
        },
        completion: { moment in
            self.moveToTImeLinePage()
        })
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.moment.context.save()
        } catch {
            print("Error in saving iCloud moment into coredata")
        }
    }
    
    func moveToTImeLinePage() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1 , execute: {
            guard let tabBar = self.storyboard?.instantiateViewController(withIdentifier: "TabBar") else {
                return }
            self.navigationController?.pushViewController(tabBar, animated: false)
        })

    }
}
