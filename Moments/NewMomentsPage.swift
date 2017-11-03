//
//  NewMomentsPage.swift
//  Moments
//
//  Created by user on 01/11/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit

class NewMomentsPage: UITableViewController , UITextFieldDelegate {
    
    @IBOutlet weak var momentName: UITextField!
    
    @IBOutlet weak var momentDescription: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var toolBar: UIToolbar!
    
    @IBOutlet weak var chooseDate: UILabel!
    @IBOutlet weak var color: UILabel!
    
    @IBOutlet weak var datePickerBottomConst: NSLayoutConstraint!
    @IBOutlet weak var viewForPicker: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toolBar.setValue(true, forKey: "hidesShadow")
        viewForPicker.isHidden = true
        datePickerBottomConst.constant = -267
        
        color.layer.cornerRadius = color.frame.size.width / 2
        
        //hides the navigation bar hairline
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        momentName.returnKeyType = UIReturnKeyType.next
        momentName.autocapitalizationType = .words
        
        momentDescription.returnKeyType = .next
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
    
    @IBAction func createButton(_ sender: Any) {
        
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
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd/MMM/yy"
        
        chooseDate.text = dateFormatter.string(from: datePicker.date)
        
        datePickerHideAnimation()
        
    }
    
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch (indexPath.section,indexPath.row) {
            
        case (2,0):
            
            datePickerShowAnimation()
            
        case (3,0):
            
            guard let pushToColorsPage = storyboard?.instantiateViewController(withIdentifier: "ColorsPage") else {
                return
            }
            
            let navController = UINavigationController(rootViewController: pushToColorsPage)
            navigationController?.present(navController, animated: true, completion: nil)
            
        default:
            print("Default Case")
        }
        
    }
    
}
