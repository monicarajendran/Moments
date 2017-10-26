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
        
//        let record = CKRecord(recordType: "Moments")
//        
//        record["momentName"] = "Testing" as CKRecordValue?
//        record["momentDescription"] = "checking" as CKRecordValue?
//
//        //creating object for container so that we can access the db
        let customContainer = CKContainer(identifier: "iCloud.com.full.moments")
//
//        //creating object for db to save records
        let publicDB = customContainer.publicCloudDatabase
//        
//        //saving the record 
//        publicDB.save(record, completionHandler: {(record,error) -> Void in
//            guard let record = record else {
//                print("error saving the record",error as Any)
//                return
//            }
//        print("record successfully saved",record)
//        })

        //retrieving the record 
        
//        let recordID = record.recordID
//        
//        publicDB.fetch(withRecordID: recordID, completionHandler: {(record,error) -> Void in
//            
//            guard let record = record else {
//                
//                print("error fetching the record",error as Any)
//                return
//            }
//            print("successfully record is fetched",record)
//        })
//        
        
        
        
//        let predicate = NSPredicate(format: "momentName == %@", "Testing")
//        
//        let query = CKQuery(recordType: "Moments", predicate: predicate)
//        publicDB.perform(query, inZoneWith: nil) {
//            (records, error) -> Void in
//            guard let records = records else {
//                print("Error querying records: ", error)
//                return
//            }
//            print("Found \(records) records matching query")
//        }
//        
//        
        
        
        
        
        //        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "blueeBackground.png")!)
        //
        //        UIGraphicsBeginImageContext(self.view.frame.size)
        //
        //        UIImage(named: "blueeBackground.png")?.draw(in: self.view.bounds)
        //
        //        let image: UIImage! = UIGraphicsGetImageFromCurrentImageContext()
        //
        //        UIGraphicsEndImageContext()
        //
        //       self.view.backgroundColor = UIColor(patternImage:image)
        
        
        
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background2.png")!)
//        
//        self.navigationController?.setNavigationBarHidden(true, animated: false)
//        
        loginLabel.layer.cornerRadius = 25
        
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
                        
                        // if let id = jsonResult["id"] {
                        
                    //}
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
