//
//  ViewController.swift
//  Moments
//
//  Created by user on 15/07/1939 Saka.
//  Copyright © 1939 Saka user. All rights reserved.
//

import UIKit

class AddMomentsPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
   
    @IBOutlet weak var eventName: UITextField!
    
    @IBAction func pickDate(_ sender: Any) {
       
    }

    @IBAction func saveButton(_ sender: Any) {
        
        container.performBackgroundTask { context  in
            
            let events = context.event.create()
            
            events.eventName = self.eventName.text
            
            do {
                try context.save()
            }
            catch{
                print("error",error)
            }
        }
        dismiss(animated: true, completion: nil)

    }
    
    @IBAction func cancelButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)

    }

    
    
    
    
    
}

