//
//  ViewController.swift
//  Moments
//
//  Created by user on 15/07/1939 Saka.
//  Copyright © 1939 Saka user. All rights reserved.
//

import UIKit
import CloudKit

let record = CKRecord(recordType: "Moment")

class AddMomentsPage: UIViewController , UITextViewDelegate , UINavigationBarDelegate {
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet var datePickerFolder: UIView!
    @IBOutlet weak var pickADate: UIButton!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var momentName: UITextField!
    @IBOutlet weak var momentDescription: UITextView!
    
    //creating this layout for animatiion of date picker
    @IBOutlet weak var datePickerBottomCons: NSLayoutConstraint!
    
    let dateFormatter = DateFormatter()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        navBar.delegate = self
        momentName.becomeFirstResponder()
        momentName.autocapitalizationType = .sentences
        
        momentDescription.delegate = self
        momentDescription.textColor = UIColor.lightGray
        momentDescription.text = "Describe the Moment.."
        momentDescription.layer.cornerRadius = 5
        momentDescription.layer.borderWidth = 0.1
        momentDescription.layer.borderColor = UIColor.black.cgColor
        
        pickADate.layer.cornerRadius = 10
        pickADate.layer.borderWidth = 0.5
        pickADate.layer.borderColor = UIColor.black.cgColor
        
        datePicker.isHidden = true
        
        toolBar.isHidden = true
        
       let navBarTitleColour = UINavigationBar.appearance()
        navBarTitleColour.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        
        return UIBarPosition.topAttached

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        datePickerBottomCons.constant = -242
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.text == "Describe the Moment.." {
            
            textView.text = ""
            
            momentDescription.textColor = .black
        }
        
        textView.becomeFirstResponder()
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text == "" {
            
            textView.textColor = .lightGray
            
            textView.text = "Describe the Moment.."
            
        }

        textView.resignFirstResponder()
    }

    func alertMessage(_ alertMsg: String){
        
        let alert = UIAlertController(title: "Alert!", message: alertMsg, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func dateComponents() -> (day: Int, month:Int, year: Int){
        
        let components = datePicker.calendar.dateComponents([.day,.month,.year], from: datePicker.date)
        
        let day = components.day
        
        let month = components.month
        
        let year = components.year
        
        return (day!,month!,year!)
        
    }
    
    @IBAction func saveButton(_ sender: Any) {
    
        guard let momentName = momentName.text , let momentDescription = momentDescription.text , !momentName.isEmpty , momentDescription != "Describe the Moment.."
            
            else {
                
                alertMessage("All Fields Required")
                
                return
        }
        
        guard  let dateLabelText = dateLabel.text , !dateLabelText.isEmpty else {
            
            alertMessage("Choose a Date")
            
            return
        }
        
        container.performBackgroundTask { context  in
            
            let moment = context.moment.create()
            
            moment.name = momentName
            
            moment.desc = momentDescription
            
            let seconds = self.datePicker.date.timeIntervalSince1970
            
            self.dateFormatter.dateStyle = .long
            
            let timeString = self.dateFormatter.string(from: self.datePicker.date)
            
            moment.momentTime = Int64(seconds)
            
            let currentDate = Date().timeIntervalSince1970 * 1000
            
            moment.createdAt = Int64(currentDate)
            
            moment.modifiedAt = Int64(currentDate)
            
            moment.searchToken = momentName + " " + momentDescription + " " + timeString
            
            moment.day = Int16(self.dateComponents().day)
            
            moment.month = Int16(self.dateComponents().month)
            
            moment.year = Int16(self.dateComponents().year)
            
            do {
                
                try context.save()
                
                CloudSyncServices.addRecordToIColud(record: moment.toICloudRecord())
                
            }
            catch{
                
                print("Error:",error)
            }
            
        }

        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func cancelButton(_ sender: Any) {
    
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func pickADateButtonAction(_ sender: Any) {
        
        self.momentDescription.resignFirstResponder()
        
        self.momentName.resignFirstResponder()
        
        datePicker.isHidden = false
        
        toolBar.isHidden = false
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {
            
            self.datePickerBottomCons.constant = 0
            
            self.view.layoutIfNeeded()
            
        }, completion: nil)
        
    }
    
    @IBAction func doneButtonOnToolBar(_ sender: Any) {
        
        dateFormatter.dateStyle = .long
        
        let dateAsString = dateFormatter.string(from: datePicker.date)
        
        dateLabel.text = dateAsString
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
            
            self.datePickerBottomCons.constant = -242
            
            self.view.layoutIfNeeded()
            
        }, completion: nil)
    }
    
    @IBAction func cancelButtonOnToolBar(_ sender: Any) {
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
            
            self.datePickerBottomCons.constant = -242
            
            self.view.layoutIfNeeded()
            
        }, completion: nil)
        
    }
    
}



extension Moment {
    
    func toICloudRecord() -> CKRecord {
        
        record["name"] = self.name as CKRecordValue?
        record["desc"] = self.desc as CKRecordValue?
        record["momentTime"] = self.momentTime as CKRecordValue?
        record["creaatedAt"] = self.createdAt as CKRecordValue?
        record["modifiedAt"] = self.modifiedAt as CKRecordValue?
        record["day"] = self.day as CKRecordValue?
        record["month"] = self.month as CKRecordValue?
        record["year"] = self.year as CKRecordValue?
       
        return record
    }
}

