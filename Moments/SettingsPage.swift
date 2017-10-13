//
//  SettingsPage.swift
//  Moments
//
//  Created by user on 18/07/1939 Saka.
//  Copyright © 1939 Saka user. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class SettingsPage: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.topItem?.title = "Settings"

    }
    func logOut(){
        
        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
        loginManager.logOut()
        
        
        guard let pushToLoginPage = storyboard?.instantiateViewController(withIdentifier: "LoginPage")
            
            else {
                
            return
        }
        
        navigationController?.setViewControllers([pushToLoginPage], animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            let alert = UIAlertController(title: "Are You Sure", message: "Logout", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.destructive, handler: nil))
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in self.logOut()} ))
            
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }

}
