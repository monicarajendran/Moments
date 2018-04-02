 //
 //  NewMomentsPage.swift
 //  Moments
 //
 //  Created by user on 01/11/17.
 //  Copyright © 2017 user. All rights reserved.
 //
 
 import UIKit
 import CloudKit
 import ActionSheetPicker_3_0
 import MBProgressHUD
 import Firebase
 import WWCalendarTimeSelector
 import UserNotifications
 
 class NewMomentsPageViewController: UITableViewController , UITextFieldDelegate , WWCalendarTimeSelectorProtocol  {
    
    
    @IBOutlet weak var chooseDateTime: UILabel!
    
    @IBOutlet weak var momentNameTextFeild: UITextField!
    
    @IBOutlet weak var momentDescTextFeild: UITextField!
    
    @IBOutlet weak var momentColorLabel: UILabel!
    
    let dateFormatter = DateFormatter()
    
    var mode = MomentMode.create.rawValue
    
    var createdMoment : Moment?
    
    var selectedColor : MomentColors?
    
    var datePicker: UIDatePicker!

    var momentDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let Identifier = UIDevice.current.identifierForVendor?.uuidString
        print(Identifier)
        momentColorLabel.layer.cornerRadius = momentColorLabel.frame.size.width / 2
        
        //hides the navigation bar hairline
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        momentNameTextFeild.autocapitalizationType = .words
        
        momentDescTextFeild.autocapitalizationType = .sentences
        
        momentNameTextFeild.becomeFirstResponder()
        
        if mode == MomentMode.edit.rawValue {
            
            momentNameTextFeild.resignFirstResponder()
            
            title = createdMoment?.name
            
            navigationController?.navigationBar.topItem?.title = " "
            
            momentNameTextFeild.text = createdMoment?.name
            
            momentDescTextFeild.text = createdMoment?.desc
            
            selectedColor = MomentColors(rawValue: (createdMoment?.color) ?? "")
            
            let time = createdMoment?.momentTime
            
            let date = Date(timeIntervalSince1970: TimeInterval(time!))
            
            momentDate = date
            
            dateFormatter.dateFormat = MomentDateFormat.dateTime.rawValue
            
            chooseDateTime.text = dateFormatter.string(from: date).lowercased()
            
            momentColorLabel.backgroundColor = UIColor(hexString: (createdMoment?.color) ?? "")
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(editMoment(sender:)))
            
            navigationItem.rightBarButtonItem?.isEnabled = false

        }
        else{
            
            title = "New Moment"
            
            selectedColor = MomentColors.red
            
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(NewMomentsPageViewController.close))
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(createMoment(sender:)))
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        momentColorLabel.backgroundColor = UIColor(hexString: (selectedColor?.rawValue) ?? "")
    
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if mode == MomentMode.create.rawValue  && indexPath == [4,0] {
            cell.isHidden = true
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        navigationItem.rightBarButtonItem?.isEnabled = true
        return true
    }
    
    func showCalenderTimer(){
        
        let selector = WWCalendarTimeSelector.instantiate()
        
        // 2. You can then set delegate, and any customization options
        selector.delegate = self
        selector.optionTopPanelTitle = "Choose date and time!"
        
        // 3. Then you simply present it from your view controller when necessary!
        self.present(selector, animated: true, completion: nil)
    }
    
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
        
        self.view.endEditing(true)
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        //since time ref
        self.momentDate = date
        self.dateFormatter.dateFormat = MomentDateFormat.dateTime.rawValue
        self.chooseDateTime.text = dateFormatter.string(from: momentDate).lowercased()
    }

   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.momentNameTextFeild {
            
            momentDescTextFeild.becomeFirstResponder()
        }
        
        if textField == self.momentDescTextFeild {
            
            momentDescTextFeild.resignFirstResponder()
            
            showCalenderTimer()
            
        }
        return true
    }
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func alertMessage(_ alertMsg: String){
        
        let alert = UIAlertController(title: "Alert!", message: alertMsg, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func saveMoment(moment: Moment) -> Moment{
        
        moment.name = momentNameTextFeild.text
        
        moment.desc = momentDescTextFeild.text ?? " "
        
        let seconds = momentDate.timeIntervalSince1970//self.datePicker.date.timeIntervalSince1970
        
        self.dateFormatter.dateStyle = .long
        
        let timeString = self.dateFormatter.string(from: momentDate)
        
        moment.momentTime = Int64(seconds)
        
        let currentDate = Date().timeIntervalSince1970
        
        moment.createdAt = Int64(currentDate)
        
        moment.modifiedAt = Int64(currentDate)
        
        moment.searchToken = momentNameTextFeild.text! + " " + momentDescTextFeild.text! + " " + timeString
        
        dateFormatter.dateFormat = MomentDateFormat.date.rawValue
        
        moment.day = Int16(self.dateFormatter.string(from: momentDate))!
//        dateFormatter.dateFormat = "EEE"
//
//        moment.month = (Int16(self.dateFormatter.string(from: datePicker)))!
//        dateFormatter.dateFormat = "yyyy"
//
//        moment.year = Int16(self.dateFormatter.string(from: datePicker))!
        
        moment.color = self.selectedColor?.rawValue
        
        notificationAlert(moment: moment)
        
        do {
            
            try container.viewContext.save()
            
        }
        catch{
            
            print("Error:",error)
        }
        
        return moment
    
    }
    
    func  createMoment(sender: UIBarButtonItem) {
        
        guard let momentName = momentNameTextFeild.text , !momentName.isEmpty   else {
            
            alertMessage("All Fields Required")

            return
        }
        
        guard  self.chooseDateTime.text != "Choose" else {
            alertMessage("Choose a Date")
            return
        }
        
        var moment = container.viewContext.moment.create()
        
        moment.momentID = NSUUID().uuidString
        
        moment = saveMoment(moment: moment)
        
        CloudSyncServices.addRecordToIColud(record: moment.toICloudRecord())
        
        Analytics.logEvent("moment_created", parameters: nil)
        
        let hud = MomentHud.showHUD(vc: self.view)
        
        hud.label.text = "Moment created successfully"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {  self.close()  } )
        
    }
    
    func editMoment(sender: UIBarButtonItem){
        
        let editedMoment = saveMoment(moment: createdMoment!)
        
        updateICloud(moment: editedMoment)
        
        Analytics.logEvent("moment_edited", parameters: nil)
        
        let hud = MomentHud.showHUD(vc: self.view)
        
        hud.label.text = "Changes saved successfully"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.close()})
        
    }
    
    func updateICloud(moment: Moment) {
        
        /// have check return
        
        CloudSyncServices.privateDb.fetch(withRecordID: CKRecordID(recordName: moment.momentID!)) { (record, error) in
            
            guard let record = record
                
                else {
                    print("error in updating the record", error as Any)
                    return
                     }
            
            moment.updateICloudRecord(record: record)
            
            CloudSyncServices.addRecordToIColud(record: record)
            
        }
    }
    
    func deleteICloud(moment: Moment){
        
        CloudSyncServices.privateDb.delete(withRecordID: CKRecordID(recordName: moment.momentID!), completionHandler: { rec , err in
            guard let record = rec else {
                print("oopssss",err as Any)
                return
            }
            print("successfully deleted",record)

        })
}
    
    func close (){
        
        momentNameTextFeild.resignFirstResponder()
        momentDescTextFeild.resignFirstResponder()
        
            if MomentMode.create.rawValue == self.mode {
                
                self.dismiss(animated: true, completion: nil)
            }
            else {
                _ = self.navigationController?.popViewController(animated: true)
            }
        
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch (indexPath.section,indexPath.row) {
            
        case (2,0):
            
            showCalenderTimer()
            momentDescTextFeild.resignFirstResponder()
            momentNameTextFeild.resignFirstResponder()
            
        case (3,0):
            
          navigationItem.rightBarButtonItem?.isEnabled = true
          
            guard let colorsVC = storyboard?.instantiateViewController(withIdentifier: "ColorsViewController") as? ColorsViewController else {
                return
            }
            colorsVC.delegate = self
            
            colorsVC.selectedColor = selectedColor
            
            let navController = UINavigationController(rootViewController: colorsVC)
            
            navigationController?.present(navController, animated: true, completion: nil)
            
        case (4,0):
            
            let alert = UIAlertController(title: "Confirm", message: "Would you like to delete", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
            
            alert.addAction(UIAlertAction(title: "Delete", style: UIAlertActionStyle.destructive, handler: { action in
                
                guard let createdMoment = self.createdMoment else { return }
                
                self.deleteICloud(moment: createdMoment)

                container.viewContext.delete(createdMoment)
                
                Analytics.logEvent("moment_deleted", parameters: nil)
                
                try!   container.viewContext.save()
                
                let hud = MomentHud.showHUD(vc: self.view)
                
                hud.label.text = "Moment deleted successfully"
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {                _ = self.navigationController?.popViewController(animated: true) })
                
            } ))
                self.present(alert, animated: true, completion: nil)
          
        default:
            
            print("Default Case")
        }
    }
}
 
 extension NewMomentsPageViewController: ColorsViewControllerDelegate {
    
    func selectedColor(color: MomentColors) {
        
        selectedColor = color
        
    }
    
    func notificationAlert(moment: Moment){
        
        let content = UNMutableNotificationContent()
        content.title = moment.name ?? ""
        content.body = moment.desc ?? ""
        content.sound = .default()
        
        let notifyDate = Date(timeIntervalSince1970: TimeInterval(moment.momentTime - 60))
        let triggerDate = Calendar.current.dateComponents([.year,.month,.day, .hour,.minute,.second], from: notifyDate)
        let tiggerNotification = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let identifier = "UYLLocalNotification"
        let request = UNNotificationRequest(identifier: identifier,
                                            content: content, trigger: tiggerNotification)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { (err) in
            if let err = err {
                print("Unable to Add Notification Request \(err), \(err.localizedDescription)")
            }
        })
    }
 }
