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
        
       // self.view.backgroundColor = UIColor(patternImage: UIImage(named: "blueBackground.png")!)
        
//        UIGraphicsBeginImageContext(self.view.frame.size)
//        
//        UIImage(named: "blueBackground.png")?.draw(in: self.view.bounds)
//        
//        let image: UIImage! = UIGraphicsGetImageFromCurrentImageContext()
//        
//        UIGraphicsEndImageContext()
//        
//        self.view.backgroundColor = UIColor(patternImage: image)
        
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        loginLabel.layer.cornerRadius = 25

    }
    
    @IBOutlet weak var loginLabel: UIButton!
    
    @IBAction func loginWithFaceBook(_ sender: Any) {
        
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) -> Void in
            
                if (error == nil){
                    
                    
                    let fbloginresult : FBSDKLoginManagerLoginResult = result!
                    
                if (result?.isCancelled)!{
                    
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
                    
                    print(result)
                    
                    if  let jsonResult = result as? [String: Any] {
                        
                        if let id = jsonResult["id"] {
                            
                        
                            
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
