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


class LoginPage: UIViewController  {
    
    let activitydata = ActivityData()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(aimation(sender:)) , name: NSNotification.Name(rawValue: "Dissmiss the safariview controller"), object: nil)
    }
    
    func aimation(sender: Notification){
        
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()

    }
    @IBAction func loginWithFaceBook(_ sender: Any) {
        
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) -> Void in
            
                if (error == nil){
                    
                    NVActivityIndicatorPresenter.sharedInstance.startAnimating(self.activitydata)
                    
                    let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if (result?.isCancelled)!{
                    return
                }
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    self.getFBUserData()
                }
            }
        }
    }
    
    func getFBUserData(){
        
        if((FBSDKAccessToken.current()) != nil){
            
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    
                   // print(result)
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
