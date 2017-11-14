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
        
        FeedBackService.sendFeedBack(feedback: Feedback.feedback(text: ""))
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
