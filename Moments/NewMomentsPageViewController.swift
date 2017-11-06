//
//  NewMomentsPage.swift
//  Moments
//
//  Created by user on 01/11/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit

class NewMomentsPageViewController: UITableViewController , UITextFieldDelegate {
    
    @IBOutlet weak var momentName: UITextField!
    
    @IBOutlet weak var momentDescription: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var toolBar: UIToolbar!
    
    @IBOutlet weak var chooseDate: UILabel!
    @IBOutlet weak var color: UILabel!
    
    @IBOutlet weak var datePickerBottomConst: NSLayoutConstraint!
    @IBOutlet weak var viewForPicker: UIView!

    let dateFormatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        toolBar.setValue(true, forKey: "hidesShadow")
        
        viewForPicker.isHidden = true
        datePickerBottomConst.constant = -267
        
        color.layer.cornerRadius = color.frame.size.width / 2
        
        //hides the navigation bar hairline
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        momentName.autocapitalizationType = .words
        
        momentDescription.autocapitalizationType = .sentences
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        guard let hexaColour = UserDefaults.standard.string(forKey: "colorChosen") else {
            
            return
        }
        
        //UIColor(hexaString:) is defined using extension
        color.backgroundColor =  UIColor(hexString: hexaColour)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.momentName {
            
            momentDescription.becomeFirstResponder()
        }
        
        if textField == self.momentDescription {
            
            momentDescription.resignFirstResponder()
            datePickerShowAnimation()
            
        }
        
        return true
    }
    
    func dateComponents() -> (day: Int, month:Int, year: Int){
        
        let components = datePicker.calendar.dateComponents([.day,.month,.year], from: datePicker.date)
        
        let day = components.day
        
        let month = components.month
        
        let year = components.year
        
        return (day!,month!,year!)
        
    }
    
    func alertMessage(_ alertMsg: String){
        
        let alert = UIAlertController(title: "Alert!", message: alertMsg, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }

    @IBAction func createButton(_ sender: Any) {
        
        guard let momentName = momentName.text , let momentDescription = momentDescription.text , !momentName.isEmpty , momentDescription != "Describe the Moment.."
            
            else {
                
                alertMessage("All Fields Required")
                
                return
        }
        
        guard  let dateLabelText = chooseDate.text , !dateLabelText.isEmpty else {
            
            alertMessage("Choose a Date")
            
            return
        }
        
        guard let hexaColour = UserDefaults.standard.string(forKey: "colorChosen") else {
            
            return
        }

        
        container.performBackgroundTask { context  in
            
            let moment = context.moment.create()
            
            moment.name = momentName
            
            moment.desc = momentDescription
            
            let seconds = self.datePicker.date.timeIntervalSinceReferenceDate
            
            self.dateFormatter.dateStyle = .long
            
            let timeString = self.dateFormatter.string(from: self.datePicker.date)
            
            moment.momentTime = Int64(seconds)
            
            let currentDate = Date().timeIntervalSinceReferenceDate
            
            moment.createdAt = Int64(currentDate)
            
            moment.modifiedAt = Int64(currentDate)
            
            moment.searchToken = momentName + " " + momentDescription + " " + timeString
            
            moment.day = Int16(self.dateComponents().day)
            
            moment.month = Int16(self.dateComponents().month)
            
            moment.year = Int16(self.dateComponents().year)
            
            moment.color = hexaColour
            
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
    
    func datePickerHideAnimation(){
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.datePickerBottomConst.constant  = -267
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        self.viewForPicker.backgroundColor = UIColor.clear
        
    }
    
    func datePickerShowAnimation(){
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            
            
            self.viewForPicker.isHidden = false
            self.viewForPicker.backgroundColor = .white
            
            self.datePickerBottomConst.constant = 0
            self.view.layoutIfNeeded()
            
        }, completion: nil)

    }
    
    @IBAction func toolBarCancel(_ sender: Any) {
        
        datePickerHideAnimation()
    }
    
    @IBAction func toolBarDone(_ sender: UIBarButtonItem) {
        
        dateFormatter.dateFormat = "dd/MMM/yy"
        
        chooseDate.text = dateFormatter.string(from: datePicker.date)
        
        datePickerHideAnimation()
        
    }
    
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch (indexPath.section,indexPath.row) {
            
        case (2,0):
            momentDescription.resignFirstResponder()
            momentName.resignFirstResponder()
            datePickerShowAnimation()
            
        case (3,0):
            
            guard let pushToColorsPage = storyboard?.instantiateViewController(withIdentifier: "ColorsPageViewController") else {
                return
            }
            
            let navController = UINavigationController(rootViewController: pushToColorsPage)
            navigationController?.present(navController, animated: true, completion: nil)
            
        default:
            print("Default Case")
        }
        
    }
    
}
