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
    
    @IBOutlet weak var momentName: UITextField!
    
    @IBOutlet weak var momentDescription: UITextField!
    
    @IBOutlet weak var color: UILabel!
    
    let dateFormatter = DateFormatter()
    
    var mode = MomentMode.create.rawValue
    
    var createdMoment : Moment?
    
    var selectedColor : MomentColors?
    
    var datePicker = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        color.layer.cornerRadius = color.frame.size.width / 2
        
        //hides the navigation bar hairline
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        chooseDate.setTitle("Choose a Date", for: .normal)
        momentName.autocapitalizationType = .words
        
        momentDescription.autocapitalizationType = .sentences
        
        if mode == MomentMode.edit.rawValue {
            
            title = createdMoment?.name
            
            navigationController?.navigationBar.topItem?.title = " "
            
            momentName.text = createdMoment?.name
            
            momentDescription.text = createdMoment?.desc
            
            selectedColor = MomentColors(rawValue: (createdMoment?.color)!)
            
            let time = createdMoment?.momentTime
            
            let date = Date(timeIntervalSince1970: TimeInterval(time!))
            
            dateFormatter.dateFormat = "dd/MMM/yy"
            
            chooseDate.setTitle(dateFormatter.string(from: date), for: .normal)
            
            color.backgroundColor = UIColor(hexString: (createdMoment?.color)!)
            
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
        
        color.backgroundColor = UIColor(hexString: (selectedColor?.rawValue)!)
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
    @IBOutlet weak var chooseDate: UIButton!
    
    @IBAction func chooseADate(_ sender: UIButton) {
        
        let datePickers = ActionSheetDatePicker(title: "", datePickerMode: UIDatePickerMode.date, selectedDate: NSDate() as Date!, doneBlock: {
            picker, value, index in
            
            self.datePicker = value as! Date
            
            self.dateFormatter.dateFormat = "dd/MMM/yy"
            
            self.chooseDate.setTitle(self.dateFormatter.string(from: self.datePicker), for: .normal)
            
            return
            
        }, cancel: { ActionStringCancelBlock in return }, origin: (sender as UIButton).superview!.superview)
        
        datePickers?.show()

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.momentName {
            
            momentDescription.becomeFirstResponder()
        }
        
        if textField == self.momentDescription {
            
            momentDescription.resignFirstResponder()
            
        }
        
        return true
    }
    
    func alertMessage(_ alertMsg: String){
        
        let alert = UIAlertController(title: "Alert!", message: alertMsg, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func saveMoment(moment: Moment) -> Moment{
        
        moment.name = momentName.text
        
        moment.desc = momentDescription.text
        
        let seconds = datePicker.timeIntervalSince1970//self.datePicker.date.timeIntervalSince1970
        
        self.dateFormatter.dateStyle = .long
        
        let timeString = self.dateFormatter.string(from: datePicker)
        
        moment.momentTime = Int64(seconds)
        
        let currentDate = Date().timeIntervalSince1970
        
        moment.createdAt = Int64(currentDate)
        
        moment.modifiedAt = Int64(currentDate)
        
        moment.searchToken = momentName.text! + " " + momentDescription.text! + " " + timeString
        
        dateFormatter.dateFormat = "dd"
        
        moment.day = Int16(self.dateFormatter.string(from: datePicker))!
        
//      moment.month = Int16(self.dateComponents().month)
      
//      moment.year = Int16(self.dateComponents().year)
        
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
        
        guard let momentNamee = momentName.text , let momentDesc = momentDescription.text ,!momentNamee.isEmpty , !momentDesc.isEmpty  else {
            
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
        
        updateICloudMoment(moment: editedMoment)
        
        close()
        
    }
    
    func updateICloudMoment(moment: Moment) {
        
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
    
    func deleteICloudMoment(moment: Moment){
        
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
            
            momentDescription.resignFirstResponder()
            momentName.resignFirstResponder()
            
        case (3,0):
          
            guard let pushToColorsPage = storyboard?.instantiateViewController(withIdentifier: "ColorsViewController") as? ColorsViewController else {
                return
            }
            pushToColorsPage.delegate = self
            
            pushToColorsPage.selectedColor = selectedColor
            
            let navController = UINavigationController(rootViewController: pushToColorsPage)
            
            navigationController?.present(navController, animated: true, completion: nil)
            
        case (4,0):
            
            let alert = UIAlertController(title: "Confirm", message: "Would you like to delete", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
            
            alert.addAction(UIAlertAction(title: "Delete", style: UIAlertActionStyle.destructive, handler: { action in
                
                self.deleteICloudMoment(moment: self.createdMoment!)
                
                guard let createdMoment = self.createdMoment else { return }
                
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
