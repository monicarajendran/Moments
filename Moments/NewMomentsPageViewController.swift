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
 
 class NewMomentsPageViewController: UITableViewController , UITextFieldDelegate {
    
    @IBOutlet weak var chooseDate: UIButton!
    
    @IBOutlet weak var momentNameTextFeild: UITextField!
    
    @IBOutlet weak var momentDescTextFeild: UITextField!
    
    @IBOutlet weak var momentColorLabel: UILabel!
    
    let dateFormatter = DateFormatter()
    
    var mode = MomentMode.create.rawValue
    
    var createdMoment : Moment?
    
    var selectedColor : MomentColors?
    
    var momentDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        momentColorLabel.layer.cornerRadius = momentColorLabel.frame.size.width / 2
        
        //hides the navigation bar hairline
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        chooseDate.setTitle("Choose a Date", for: .normal)
        
        momentNameTextFeild.autocapitalizationType = .words
        
        momentDescTextFeild.autocapitalizationType = .sentences
        
        momentNameTextFeild.becomeFirstResponder()
        
        if mode == MomentMode.edit.rawValue {
            
            title = createdMoment?.name
            
            navigationController?.navigationBar.topItem?.title = " "
            
            momentNameTextFeild.text = createdMoment?.name
            
            momentDescTextFeild.text = createdMoment?.desc
            
            selectedColor = MomentColors(rawValue: (createdMoment?.color)!)
            
            let time = createdMoment?.momentTime
            
            let date = Date(timeIntervalSince1970: TimeInterval(time!))
            
            momentDate = date
            
            dateFormatter.dateFormat = MomentDateFormat.short.rawValue
            
            chooseDate.setTitle(dateFormatter.string(from: date), for: .normal)
            
            momentColorLabel.backgroundColor = UIColor(hexString: (createdMoment?.color)!)
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(editMoment(sender:)))
            
        }
        else{
            
            title = "New Moment"
            
            selectedColor = MomentColors.red
            
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(NewMomentsPageViewController.close))
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(createMoment(sender:)))
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        momentColorLabel.backgroundColor = UIColor(hexString: (selectedColor?.rawValue)!)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (MomentMode.create.rawValue == mode) && (indexPath == [4,0]) {
            return 0.0
        }
        else {
            return 44.0
        }
    }
 
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if (MomentMode.create.rawValue == mode) && (section == 4) {
            return 0.0
        }
        else {
            return 22.0
        }
    }
    
    @IBAction func chooseADate(_ sender: UIButton) {
        
        let datePicker = ActionSheetDatePicker(title: "", datePickerMode: UIDatePickerMode.date, selectedDate: NSDate() as Date!, doneBlock: {
            picker, value, index in
            
            self.momentDate = value as! Date
            
            self.dateFormatter.dateFormat = MomentDateFormat.short.rawValue
            
            self.chooseDate.setTitle(self.dateFormatter.string(from: self.momentDate), for: .normal)
            
            return
            
        }, cancel: { ActionStringCancelBlock in return }, origin: (sender as UIButton).superview!.superview)
        
        datePicker?.show()

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.momentNameTextFeild {
            
            momentDescTextFeild.becomeFirstResponder()
        }
        
        if textField == self.momentDescTextFeild {
            
            momentDescTextFeild.resignFirstResponder()
            
        }
        
        return true
    }
    
    func alertMessage(_ alertMsg: String){
        
        let alert = UIAlertController(title: "Alert!", message: alertMsg, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func saveMoment(moment: Moment) -> Moment{
        
        moment.name = momentNameTextFeild.text
        
        moment.desc = momentDescTextFeild.text
        
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
        
        do {
            
            try container.viewContext.save()
            
        }
        catch{
            
            print("Error:",error)
        }
        
        close()

        return moment
    
    }
    
    func  createMoment(sender: UIBarButtonItem) {
        
        guard let momentName = momentNameTextFeild.text , let momentDesc = momentDescTextFeild.text ,!momentName.isEmpty , !momentDesc.isEmpty  else {
            
            alertMessage("All Fields Required")

            return
        }
        
        guard   "Choose a Date" != chooseDate.currentTitle else {
            alertMessage("Choose a Date")
            return
        }
        
        print("create method called")
        
        var moment = container.viewContext.moment.create()
        
        moment.momentID = NSUUID().uuidString
        
        moment = saveMoment(moment: moment)
        
        CloudSyncServices.addRecordToIColud(record: moment.toICloudRecord())
        
    }
    
    func editMoment(sender: UIBarButtonItem){
        
        let editedMoment = saveMoment(moment: createdMoment!)
        
        updateICloud(moment: editedMoment)
        
        close()
        
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
        
        if MomentMode.create.rawValue == mode {
            
            dismiss(animated: true, completion: nil)
        }
        else {
            
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch (indexPath.section,indexPath.row) {
            
        case (2,0):
            
            momentDescTextFeild.resignFirstResponder()
            momentNameTextFeild.resignFirstResponder()
            
        case (3,0):
          
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
                
                try!   container.viewContext.save()

                _ = self.navigationController?.popViewController(animated: true) } ))
            
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
 }
