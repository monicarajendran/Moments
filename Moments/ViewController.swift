
//  ViewController.swift
//  Moments
//
//  Created by user on 03/08/1939 Saka.
//  Copyright © 1939 Saka user. All rights reserved.
//

import UIKit
import CloudKit

class ViewController: UIViewController {

    @IBOutlet weak var momentDate: UILabel!
    @IBOutlet weak var momentDescription: UILabel!
    @IBOutlet weak var momentName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let predicate = NSPredicate(format: "momentDescription != %@", "Testing")
        
        let query = CKQuery(recordType: "Moments", predicate: predicate)
        publicDb.perform(query, inZoneWith: nil) {
            (records, error) -> Void in
            guard let records = records, let momentName = records[0].object(forKey: "momentName") as? String else {
                print("Error querying records: ", error as Any)
                return
            }
            self.momentName.text = momentName
            self.momentDescription.text = records[0].object(forKey: "momentDescription") as? String
            self.momentDate.text = records[0].object(forKey: "momentDate") as? String
            print("Found \(records) records matching query")
        }
        print("exit")
    }

}
