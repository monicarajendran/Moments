//
//  LaunchViewController.swift
//  Moments
//
//  Created by user on 29/11/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit
import LocalAuthentication
import CryptoSwift

protocol AppTextfieldDelegate: class {
    func backspacePressed()
}

class AppTextfield: UITextField {
    
    var textfieldDelegate: AppTextfieldDelegate?
    
    override func deleteBackward() {
        
        textfieldDelegate?.backspacePressed()
        super.deleteBackward()
    }
}


class LaunchViewController: UIViewController, UITextFieldDelegate, AppTextfieldDelegate  {

    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: AppTextfield!
    @IBOutlet weak var textField3: AppTextfield!
    @IBOutlet weak var textField4: AppTextfield!
    
    var arrayOfTextFields : [UITextField] = []
    var activeTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegates()
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        arrayOfTextFields = [textField1,textField2,textField3,textField4]
        
        for textFields in arrayOfTextFields {
            textFields.addTarget(self, action: #selector(textfieldDidChange(textFeild:)), for: .editingChanged)
        }
        
        if UserDefaults.standard.bool(forKey: "touchEnabled"){
            authenticationWithTouchID()
        }
        else{
            
            textField1.becomeFirstResponder()
        }
    }
    
    func setupDelegates() {
        
        self.textField2.textfieldDelegate = self
        self.textField3.textfieldDelegate = self
        self.textField4.textfieldDelegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func touchIDButton(_ sender: UIButton) {
        authenticationWithTouchID()
    }
    
    @objc func textfieldDidChange(textFeild: UITextField){
        
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
                textField4.resignFirstResponder()
                textField4.backgroundColor = UIColor(hexString: MomentColors.blue.rawValue)
                verifyPasscode()
                
            default :
                break
            }
        }
    }
    
    func verifyPasscode(){
        
        let enteredPasscode = textField1.text! + textField2.text!  + textField3.text!  + textField4.text!
        
        let hashValue = enteredPasscode.sha1()
        
        if hashValue == UserDefaults.standard.string(forKey: "hashPasscode") {
            guard let tabBar = self.storyboard?.instantiateViewController(withIdentifier: "TabBar") else {
                return
            }
            self.navigationController?.pushViewController(tabBar, animated: true)
        }
        else {
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    func backspacePressed() {
        
        activeTextField.resignFirstResponder()
        
        let perviousTextField = view.viewWithTag(activeTextField.tag - 1) as? UITextField
        
        perviousTextField?.text = nil
        perviousTextField?.backgroundColor = .white
        perviousTextField?.becomeFirstResponder()
        
        print("back button pressed")
        
    }
    
    func notifyUser(title: String , message: String){
        
        DispatchQueue.main.async {
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in        self.textField1.becomeFirstResponder()
}))
            
            self.present(alert, animated: true, completion: nil)

        }
    }
    
    func authenticationWithTouchID(){
        
        textField1.resignFirstResponder()

        let authenticationContext = LAContext()
        
        var error : NSError?
        
        // test touch ID
        guard authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            
            switch error?.code {
                
            case LAError.Code.touchIDNotEnrolled.rawValue?:
                notifyUser(title: "Error", message: "Device not Enrolled with Touch ID")
                
            case LAError.Code.touchIDNotAvailable.rawValue? :
                notifyUser(title: "Error", message: "Device Doesnot support Touch ID")
                
            case LAError.Code.passcodeNotSet.rawValue?:
                notifyUser(title: "Error", message: "Passcode not set")
            default:
                print("default case ")
            }

            return
        }
        
        // authenticate the user
        authenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Frigerprint is required to open this app", reply:  {(success , err ) in
            //DispatchQueue.main.async {
            
            if success  {
                
                DispatchQueue.main.async {
                    guard let tabBar = self.storyboard?.instantiateViewController(withIdentifier: "TabBar") else {
                        return
                    }
                    self.navigationController?.pushViewController(tabBar, animated: true)
                    print("successfull")
                }
                
            }
                
            else {
                
                switch err {
                    
                case LAError.userCancel? :
                    DispatchQueue.main.async {
                        self.textField1.becomeFirstResponder()
                    }
                    break
                    
                case LAError.authenticationFailed?:
                    self.notifyUser(title: "Authenticaion failed", message: "Try Again?")
                    
                case LAError.userFallback?:
                    self.textField1.becomeFirstResponder()
                    
                case LAError.touchIDLockout?:
                    self.notifyUser(title: "Too many Failed attempts", message: "Use Passcode to unlock")
                    
                case LAError.touchIDNotEnrolled?:
                    self.notifyUser(title: "Fingerorint is not enrolled", message: "ok")
                    
                default:
                    print("default  case")
                    
                }
            }
        })
        //}
    }
}

