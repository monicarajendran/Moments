//
//  FeedBackViewController.swift
//  Moments
//
//  Created by user on 13/11/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit

class FeedBackViewController: UIViewController {
    
    @IBOutlet weak var feedBackText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedBackText.layer.cornerRadius = 5
        
        title = "Feedback"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Send", style: .plain, target: self, action: #selector(sendFeedBack(sender:)))
    }
    override func viewDidLayoutSubviews() {
        
        self.feedBackText.setContentOffset(.zero, animated: false)

    }
    func sendFeedBack(sender: UIBarButtonItem){
        
        if feedBackText.text.characters.count > 30 {
            
            let alert = UIAlertController(title: "THANKYOU!", message: "Thankyou for your feedback", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: self.close))
            
            self.present(alert, animated: true, completion: nil)
            
        FeedBackService.sendFeedBack(feedback: Feedback.feedback(text: feedBackText.text),completion: nil)
        
        }
        else {
            emptyFieldAlert()
        }
    }
    
    func close(action: UIAlertAction) {
        self.navigationController?.popViewController(animated: true)

    }
    
    func emptyFieldAlert(){
        
        let alert = UIAlertController(title: "", message: "Please Enter a minimum of 30 characters", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
}
