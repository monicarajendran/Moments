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
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.topItem?.title = "Settings"

    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        switch (indexPath.section, indexPath.row) {
            
//        case (1,0) :
//            
//            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Moment")
//            
//            let bactchDeleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
//
//            do{
//                try container.viewContext.execute(bactchDeleteRequest)
//            }
//            catch{
//                print("Error Occoured")
//            }
//            
//            default:
//            print("No cases are matched")
       }
    }


