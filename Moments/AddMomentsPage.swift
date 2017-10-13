//
//  ViewController.swift
//  Moments
//
//  Created by user on 15/07/1939 Saka.
//  Copyright © 1939 Saka user. All rights reserved.
//

import UIKit

class AddMomentsPage: UIViewController , UITextViewDelegate {
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        momentDescription.delegate = self
        momentDescription.textColor = UIColor.lightGray
        momentDescription.layer.cornerRadius = 5
        momentDescription.layer.borderWidth = 0.1
        momentDescription.layer.borderColor = UIColor.black.cgColor
        
        pickADate.layer.cornerRadius = 10
        pickADate.layer.borderWidth = 0.5
        pickADate.layer.borderColor = UIColor.black.cgColor
        
        datePicker.isHidden = true
        
        toolBar.isHidden = true
    }
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet var datePickerFolder: UIView!
    @IBOutlet weak var pickADate: UIButton!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var momentName: UITextField!
    @IBOutlet weak var momentDescription: UITextView!
    
    
   
    func alertMessage(_ alertMsg: String){
        
        let alert = UIAlertController(title: "Alert", message: alertMsg, preferredStyle: UIAlertControllerStyle.alert)
        
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
        
        guard let momentName = momentName.text , let momentDescription = momentDescription.text , !momentName.isEmpty , !momentDescription.isEmpty
            
            else {
                
                alertMessage("All Fields Required")
                
                return
        }
        
        container.performBackgroundTask { context  in
            
            let moments = context.moment.create()
            
            moments.momentName = momentName
            
            moments.dayOfTheMoment = Int16(self.dateComponents().day)
            
            moments.year = Int16(self.dateComponents().year)
            
            moments.monthNumber = Int16(self.dateComponents().month)
            
            moments.momentDescription = momentDescription
            
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
    
    @IBAction func pickADateButtonAction(_ sender: Any) {
       
        datePicker.isHidden = false
        toolBar.isHidden = false
        
    }
    
    @IBAction func doneButtonOnToolBar(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .long
        
        let dateAsString = dateFormatter.string(from: datePicker.date)
        
        dateLabel.text = dateAsString
        dateLabel.isEnabled = true

        datePicker.isHidden = true
            
        toolBar.isHidden = true
            
    }
    
    @IBAction func cancelButtonOnToolBar(_ sender: Any) {
        
        datePicker.isHidden = true
        toolBar.isHidden = true
    }
    
}

