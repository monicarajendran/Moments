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
    
    func logOut(){
        
        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
        
        FBSDKGraphRequest(graphPath: "me/permissions/", parameters: nil, httpMethod: "DELETE").start(completionHandler: {(connection,result,error)-> Void in
            
            print("the delete permission is \(result)")
            
        })
        
        loginManager.logOut()
        
        guard let pushToLoginPage = self.storyboard?.instantiateViewController(withIdentifier: "LoginPage")
            
            else {
                
            return
        }
        
        tabBarController?.navigationController?.setViewControllers([pushToLoginPage], animated: true)
    }
    
    func alertMessage(){
        
        let alert = UIAlertController(title: "", message: "Are You Sure you want to Logout", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Logout", style: UIAlertActionStyle.destructive, handler: { action in self.logOut()} ))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 1 {
            
            
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Moment")
            
            let bactchDeleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
            
            do{
                try container.viewContext.execute(bactchDeleteRequest)
            }
            catch{
                print("Error Occoured")
            }
            
            alertMessage()
            logOut()
            
        }
        else {
            guard let iCloudData = storyboard?.instantiateViewController(withIdentifier: "ViewController")
                else {
                    return
            }
            navigationController?.pushViewController(iCloudData, animated: true)
        }
        
    }

}
