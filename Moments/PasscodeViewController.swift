//
//  PasscodeViewController.swift
//  Moments
//
//  Created by user on 29/11/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit

class PasscodeViewController: UIViewController {
    
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textField4: UITextField!
    
    @IBOutlet weak var passcodeSubHeading: UILabel!
    
    var mode = MomentPasscode.setPAsscode.rawValue
    
    var setPasscode = ""
    
    var arrayOfTextFields : [UITextField] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Passcode Lock"
        
        passcodeSubHeading.alpha = 0.6
        
        arrayOfTextFields = [textField1,textField2,textField3,textField4]
        
        for textFields in arrayOfTextFields {
            textFields.addTarget(self, action: #selector(textfieldDidChange(textFeild:)), for: .editingChanged)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        passcodeSubHeading.text = "Set Passcode"
        textField1.becomeFirstResponder()
    }
    
    func textfieldDidChange(textFeild: UITextField){
        
        let text = textFeild.text
        
        if text?.utf16.count == 1 {
            
            switch textFeild {
                
            case textField1:
                textField2.becomeFirstResponder()
                textField1.backgroundColor = UIColor(hexString: MomentColors.blue.rawValue)
                
            case textField2:
                textField3.becomeFirstResponder()
                textField2.backgroundColor = UIColor(hexString: MomentColors.blue.rawValue)
                
            case textField3:
                textField4.becomeFirstResponder()
                textField3.backgroundColor = UIColor(hexString: MomentColors.blue.rawValue)
                
            case textField4:
                textField4.backgroundColor = UIColor(hexString: MomentColors.blue.rawValue)
                textField4.resignFirstResponder()
                // set mode
                if mode == MomentPasscode.setPAsscode.rawValue
                {
                    for textFields in arrayOfTextFields {
                        self.setPasscode += textFields.text!
                        textFields.backgroundColor = UIColor(hexString: MomentColors.green.rawValue)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        
                        self.passcodeSubHeading.text = "Confirm Passcode"
                        
                        for textFields in self.arrayOfTextFields {
                            textFields.text = nil
                            textFields.backgroundColor = .white
                            self.textField1.becomeFirstResponder()
                            
                        }
                    })
                    
                    mode = MomentPasscode.confirmPasscode.rawValue
                    
                    print("setpasscode",setPasscode)
                    
                }
                    
                    // confirm mode
                else {
                    
                    let confirmPasscode = textField1.text! + textField2.text! + textField3.text! + textField4.text!
                    
                    print(confirmPasscode,"confirm passcode")
                    
                    if confirmPasscode == setPasscode {
                        
                        for textFields in self.arrayOfTextFields {
                            textFields.backgroundColor = UIColor(hexString: MomentColors.green.rawValue)
                        }
                        
                        guard let hashPasscode = SHA1.hexString(from: confirmPasscode) else {
                            return
                        }
                        
                        UserDefaults.standard.set(true, forKey: "passcodeEnabled")
                        UserDefaults.standard.set(hashPasscode, forKey: "hashPasscode")
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                            
                            self.navigationController?.popViewController(animated: true)})
                    }
                        
                    else {
                        
                        UserDefaults.standard.removeObject(forKey: "passcodeEnabled")
                        for textFields in self.arrayOfTextFields {
                            textFields.backgroundColor = UIColor(hexString: MomentColors.red.rawValue)
                            
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                            for textFields in self.arrayOfTextFields {
                                textFields.text = nil
                                textFields.backgroundColor = .white
                            }
                            self.textField1.becomeFirstResponder()
                            
                        })
                    }
                }
                
            default:
                break
            }
        }
    }
}
