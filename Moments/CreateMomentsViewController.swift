//
//  CreateMomentsViewController.swift
//  Moments
//
//  Created by Monica on 02/04/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import Apploader

class CreateMomentsViewController: UIViewController {

    @IBOutlet weak var createPageTopView: UIView!
    @IBOutlet weak var momentNameTextfield: UITextField!
    @IBOutlet weak var momentDescTextfield: UITextField!
    
    var alterHud: MBProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       setupView()
       alterHud = getAlertHUD(srcView: self.view)

    }
    
    func setupView() {
        
        UIApplication.shared.statusBarStyle = .lightContent

        self.momentNameTextfield.attributedPlaceholder = NSAttributedString(string: "Enter Title", attributes: [NSForegroundColorAttributeName: UIColor.white])
        self.momentNameTextfield.becomeFirstResponder()
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        close()
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        createMoment(sender: sender)
    }
    
    func saveMoment(moment: Moment) -> Moment{
        
        moment.name = momentNameTextfield.text
        moment.desc = momentDescTextfield.text

        let currentDate = Date().timeIntervalSince1970
        moment.createdAt = Int64(currentDate)
        moment.modifiedAt = Int64(currentDate)
        
        do {
            try container.viewContext.save()
        }
        catch{
            print("Error:",error)
        }
        return moment
    }
    
    func  createMoment(sender: UIButton) {
        
        guard let momentName = momentNameTextfield.text , !momentName.isEmpty   else {
            alterHud.showText(msg: "Title is Required", detailMsg: "", delay: 1)
            return
        }
        
        var moment = container.viewContext.moment.create()
        moment.momentID = NSUUID().uuidString
        moment = saveMoment(moment: moment)
        
        alterHud.showText(msg: "Moment Created Successfully!", detailMsg: "", delay: 1)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {  self.close()  } )
    }
    
    func close() {
        
        momentNameTextfield.resignFirstResponder()
        momentDescTextfield.resignFirstResponder()
        dismiss(animated: true, completion: nil)
    }
}
