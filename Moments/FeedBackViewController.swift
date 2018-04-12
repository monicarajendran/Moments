//
//  FeedBackViewController.swift
//  Moments
//
//  Created by user on 13/11/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit

import ActionSheetPicker_3_0

import MBProgressHUD

import Firebase

class FeedBackViewController: UIViewController {
    
    @IBOutlet weak var feedBackText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedBackText.layer.cornerRadius = 5
        
        title = "Feedback"
        
        feedBackText.becomeFirstResponder()
        
        self.navigationController?.navigationBar.topItem?.title = " "
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Send", style: .plain, target: self, action: #selector(sendFeedBack(sender:)))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        feedBackText.resignFirstResponder()
    }
    
    override func viewDidLayoutSubviews() {
        
        self.feedBackText.setContentOffset(.zero, animated: false)
        
    }
    
    @objc func sendFeedBack(sender: UIBarButtonItem){
        
        if feedBackText.text.characters.count > 10 {
            
            FeedBackService.sendFeedBack(feedback: Feedback.feedback(text: self.feedBackText.text),completion: nil)
            
            Analytics.logEvent("feedback_sent", parameters: nil)

                let hud = MomentHud.showHUD(vc: self.view)
                hud.label.text = "Thankyou for feedback"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                _ = self.navigationController?.popViewController(animated: true)
            })
      
            }
            
        else {
            
            emptyFieldAlert()
        }
    }
    
    func emptyFieldAlert(){
        
        let alert = UIAlertController(title: "", message: "Please Enter a minimum of 10 characters", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
}
