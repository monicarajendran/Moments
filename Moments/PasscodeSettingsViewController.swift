//
//  PasscodeSettingsViewController.swift
//  Moments
//
//  Created by user on 30/11/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit

class PasscodeSettingsViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        title = "TouchID & Passcode"
        changePasscode.isEnabled = false
        passcodeCheck()
    }
    
    @IBOutlet weak var passcode: UISwitch!
    
    @IBOutlet weak var touchID: UISwitch!
    
    @IBOutlet weak var changePasscode: UISwitch!
    
    func passcodeCheck(){
        
        if UserDefaults.standard.bool(forKey: "passcodeEnabled"){
    
            passcode.isOn = true
            touchID.isOn = true
            
            changePasscode.isEnabled = true
            
            UserDefaults.standard.set(true, forKey: "touchEnabled")
        }
        else{
            touchID.isOn = false
            passcode.isOn = false
        }
    }
    
    @IBAction func passcodeSwitch(_ sender: UISwitch) {
    
    if sender.isOn {
            passcodeCheck()
            guard let passcodeVc = storyboard?.instantiateViewController(withIdentifier: "PasscodeViewController") else { return }
            navigationController?.pushViewController(passcodeVc, animated: true)
        }
        
    else{
        touchID.isOn = false
        UserDefaults.standard.removeObject(forKey: "passcodeEnabled")
        
        }
    }
    
    @IBAction func touchIDSwitch(_ sender: UISwitch) {
        
    if touchID.isOn {
            UserDefaults.standard.set(true, forKey: "touchEnabled")
            UserDefaults.standard.synchronize()
            
        }
        else{
            UserDefaults.standard.removeObject(forKey: "touchEnabled")
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath == [2,0] {
            guard let passcodeVc = self.storyboard?.instantiateViewController(withIdentifier: "PasscodeViewController") else {
                return }
            self.navigationController?.pushViewController(passcodeVc, animated: true)
        }
    }
}
