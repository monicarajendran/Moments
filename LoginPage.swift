//
//  LoginPage.swift
//  Moments
//
//  Created by user on 18/07/1939 Saka.
//  Copyright © 1939 Saka user. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import NVActivityIndicatorView
import CloudKit

class LoginPage: UIViewController  {
    
    let activitydata = ActivityData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginLabel.layer.cornerRadius = 25

        let recordID = record.recordID

        CloudSyncServices.privateDb.fetch(withRecordID: recordID, completionHandler: {(record,error) -> Void in
            
            guard let record = record else {
                
                print("error fetching the record",error as Any)
                return
            }
                        
            print("successfully record is fetched",record)
            
        })
        
        
    self.navigationController?.setNavigationBarHidden(true, animated: false)

    }
    @IBOutlet weak var loginLabel: UIButton!
    
    @IBAction func loginWithFaceBook(_ sender: Any) {
        
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) -> Void in
            
            if (error == nil)
            {
                
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                
                if (result?.isCancelled)!
                {
                    
                    NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                    
                    return
                }
                
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    NVActivityIndicatorPresenter.sharedInstance.startAnimating(self.activitydata)
                    self.getFBUserData()
                }
            }
        }
    }
    
    func getFBUserData(){
        
        if((FBSDKAccessToken.current()) != nil){
            
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    
                    if  let jsonResult = result as? [String: Any] {
                        
                         if let email = jsonResult["email"] {
                        
                            UserDefaults.standard.set(email, forKey: "email")
                            UserDefaults.standard.synchronize()
                            
                    }
                }
                
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                
                guard let pushToTimelinePage = self.storyboard?.instantiateViewController(withIdentifier: "TabBar") else {
                    return
                }
                
                self.navigationController?.pushViewController(pushToTimelinePage, animated: true)
                    
                }
            })
        }
    }
}
