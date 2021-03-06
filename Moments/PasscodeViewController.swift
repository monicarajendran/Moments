//
//  PasscodeViewController.swift
//  Moments
//
//  Created by user on 29/11/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit

class PasscodeViewController: UIViewController , UITextFieldDelegate , AppTextfieldDelegate  {

    @IBOutlet weak var passcodeTextField1: UITextField!
    @IBOutlet weak var passcodeTextField2: AppTextfield!
    @IBOutlet weak var passcodeTextField3: AppTextfield!
    @IBOutlet weak var passcodeTextField4: AppTextfield!
    @IBOutlet weak var passcodeSubHeading: UILabel!
    
    var mode = MomentPasscode.setPasscode.rawValue
    
    var setPasscodeText = ""
    
    var activeTextField = UITextField()
    
    var arrayOfTextFields : [UITextField] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegates()
        passcodeSubHeading.alpha = 0.6
        
        arrayOfTextFields = [passcodeTextField1,passcodeTextField2,passcodeTextField3,passcodeTextField4]
        
        for textFields in arrayOfTextFields {
            textFields.addTarget(self, action: #selector(textfieldDidChange(textFeild:)), for: .editingChanged)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        passcodeSubHeading.text = "Set New Passcode"
        
        if mode == MomentPasscode.removePasscode.rawValue {
            passcodeSubHeading.text = "Remove Your Passcode"
        }
        
        passcodeTextField1.becomeFirstResponder()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    func setupDelegates() {
        
        self.passcodeTextField2.textfieldDelegate = self
        self.passcodeTextField3.textfieldDelegate = self
        self.passcodeTextField4.textfieldDelegate = self
    }
    
    func backspacePressed() {
        
            activeTextField.resignFirstResponder()
            
            let perviousTextField = view.viewWithTag(activeTextField.tag - 1) as? UITextField
            
            perviousTextField?.text = nil
            perviousTextField?.backgroundColor = .white
            perviousTextField?.becomeFirstResponder()

    }
    
    func wrongCredentials(){
        
        for textFields in self.arrayOfTextFields {
            textFields.backgroundColor = UIColor(hexString: MomentColors.red.rawValue)
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            for textFields in self.arrayOfTextFields {
                textFields.text = nil
                textFields.backgroundColor = .white
            }
            self.passcodeTextField1.becomeFirstResponder()
            
        })
    }
    
    @IBAction func cancelItem(_ sender: UIButton) {
        
        self.activeTextField.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func textfieldDidChange(textFeild: UITextField){
        
        let text = textFeild.text
        
        if text?.utf16.count == 1 {
            
            switch textFeild {
                
            case passcodeTextField1:
                passcodeTextField2.becomeFirstResponder()
                passcodeTextField1.backgroundColor = UIColor(hexString: MomentColors.blue.rawValue)
                
            case passcodeTextField2:
                passcodeTextField3.becomeFirstResponder()
                passcodeTextField2.backgroundColor = UIColor(hexString: MomentColors.blue.rawValue)
                
            case passcodeTextField3:
                passcodeTextField4.becomeFirstResponder()
                passcodeTextField3.backgroundColor = UIColor(hexString: MomentColors.blue.rawValue)
                
            case passcodeTextField4:
                passcodeTextField4.backgroundColor = UIColor(hexString: MomentColors.blue.rawValue)
                passcodeTextField4.resignFirstResponder()
                
                // set mode
                if mode == MomentPasscode.setPasscode.rawValue
                {
                    for textFields in arrayOfTextFields {
                        self.setPasscodeText += textFields.text!
                        textFields.backgroundColor = UIColor(hexString: MomentColors.green.rawValue)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        
                        self.passcodeSubHeading.text = "Confirm Your Passcode"
                        
                        for textFields in self.arrayOfTextFields {
                            textFields.text = nil
                            textFields.backgroundColor = .white
                            self.passcodeTextField1.becomeFirstResponder()
                            
                        }
                    })
                    
                    mode = MomentPasscode.confirmPasscode.rawValue
                    
                    print("setpasscode",setPasscodeText)
                    
                }
                    
                // confirm mode
                else if mode == "confirm" {
                    
                    let confirmPasscodeText = passcodeTextField1.text! + passcodeTextField2.text! + passcodeTextField3.text! + passcodeTextField4.text!
                    
                    print(confirmPasscodeText,"confirm passcode")
                    
                    if confirmPasscodeText == setPasscodeText {
                        
                        for textFields in self.arrayOfTextFields {
                            textFields.backgroundColor = UIColor(hexString: MomentColors.green.rawValue)
                        }
                        
                        UserDefaults.standard.set(true, forKey: "passcodeEnabled")
                        UserDefaults.standard.set(confirmPasscodeText.sha1(), forKey: "hashPasscode")
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                            self.dismiss(animated: true, completion: nil)
                            })
                    }
                        
                    else {
                        
                        UserDefaults.standard.removeObject(forKey: "passcodeEnabled")
                        wrongCredentials()
              
                    }
                }
                
                //review mode
                else {
                    
                    let passcode = passcodeTextField1.text! + passcodeTextField2.text! + passcodeTextField3.text! + passcodeTextField4.text!
                    
                    let hassPasscode = passcode.sha1()
                    
                    if hassPasscode == UserDefaults.standard.string(forKey: "hashPasscode") {
                        
                        UserDefaults.standard.removeObject(forKey: "passcodeEnabled")
                        self.dismiss(animated: true, completion: nil)

                    }
                    else {
                        UserDefaults.standard.set(true, forKey: "passcodeEnabled")
                        wrongCredentials()

                    }
                }

            default:
                break
            }
        }
    }
}
