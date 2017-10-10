//
//  LoginPage.swift
//  Moments
//
//  Created by user on 18/07/1939 Saka.
//  Copyright © 1939 Saka user. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginPage: UIViewController , FBSDKLoginButtonDelegate  {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBSDKLoginButton()
        
        loginButton.frame = CGRect(x: 16, y: 200, width: view.frame.width - 32 , height: 50)
        
        view.addSubview(loginButton)
        
        loginButton.center = view.center
        
        loginButton.delegate = self

    }
    
     func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if error == nil {
            
            guard let homeTab = self.storyboard?.instantiateViewController(withIdentifier: "TimelinePage") else { return }
            
            navigationController?.pushViewController(homeTab, animated: true)
            
        }
        
        else{
            print(error)
            print("error occured")
        }
        
    }

     func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!){
        
    }


   
}
