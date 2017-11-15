 //
 //  NewMomentsPage.swift
 //  Moments
 //
 //  Created by user on 01/11/17.
 //  Copyright © 2017 user. All rights reserved.
 //
 
 import UIKit
 import CloudKit
 
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
    
    var mode = MomentMode.create.rawValue
    
    var createdMoment : Moment?
    
    var selectedColor : MomentColors?
    
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
        
        if mode == MomentMode.edit.rawValue {
            
            title = "Moment Details"
            
            momentName.text = createdMoment?.name
            
            momentDescription.text = createdMoment?.desc
            
            selectedColor = MomentColors(rawValue: (createdMoment?.color)!)
            
            let time = createdMoment?.momentTime
            
            let date = Date(timeIntervalSince1970: TimeInterval(time!))
            
            dateFormatter.dateFormat = "dd/MMM/yy"
            
            chooseDate.text = dateFormatter.string(from: date)
            
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
    
    func saveMoment(moment: Moment) -> Moment{
        
        guard let momentName = momentName.text , let momentDescription = momentDescription.text , !momentName.isEmpty , momentDescription != "Describe the Moment.."
            
            else {
                alertMessage("All Fields Required")
                
                return moment
        }
        
        guard  let dateLabelText = chooseDate.text , !dateLabelText.isEmpty else {
            
            alertMessage("Choose a Date")
            
            return moment
        }
        
        moment.name = momentName
        
        moment.desc = momentDescription
        
        let seconds = self.datePicker.date.timeIntervalSince1970
        
        self.dateFormatter.dateStyle = .long
        
        let timeString = self.dateFormatter.string(from: self.datePicker.date)
        
        moment.momentTime = Int64(seconds)
        
        let currentDate = Date().timeIntervalSince1970
        
        moment.createdAt = Int64(currentDate)
        
        moment.modifiedAt = Int64(currentDate)
        
        moment.searchToken = momentName + " " + momentDescription + " " + timeString
        
        moment.day = Int16(self.dateComponents().day)
        
        moment.month = Int16(self.dateComponents().month)
        
        moment.year = Int16(self.dateComponents().year)
        
        moment.color = self.selectedColor?.rawValue
        
        do {
            
            try container.viewContext.save()
            
        }
        catch{
            
            print("Error:",error)
        }
        
        return moment
        
    }
    
    func  createMoment(sender: UIBarButtonItem) {
        
        print("create method called")
        
        var moment = container.viewContext.moment.create()
        
        moment.momentID = NSUUID().uuidString
        
        moment = saveMoment(moment: moment)
        
        CloudSyncServices.addRecordToIColud(record: moment.toICloudRecord())
        
        close()
        
    }
    
    func editMoment(sender: UIBarButtonItem){
        
        let editedMoment = saveMoment(moment: createdMoment!)
        
        updateMoment(moment: editedMoment)
        
        close()
        
    }
    
    func updateMoment(moment: Moment) {
        
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
    
    func deleteMoment(moment: Moment){
        
        CloudSyncServices.privateDb.delete(withRecordID: CKRecordID(recordName: moment.momentID!), completionHandler: { rec , err in
            guard let record = rec else {
                print("oopssss",err)
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
            
            self.navigationController?.popViewController(animated: true)
        }
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
        
        if mode == MomentMode.edit.rawValue{
        scrolDown()
        }
    }
    
    @IBAction func toolBarDone(_ sender: UIBarButtonItem) {
        
        dateFormatter.dateFormat = "dd/MMM/yy"
        
        chooseDate.text = dateFormatter.string(from: datePicker.date)
        
        datePickerHideAnimation()
        
        if mode == MomentMode.edit.rawValue{
            scrolDown()
        }
    }
    func scrolDown(){
        let indexPath = NSIndexPath(row: 0,section: 0) as IndexPath
        self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    func scrollToFirstRow(){
        let indexPath = NSIndexPath(row: 0, section: 1) as? IndexPath
        self.tableView.scrollToRow(at: indexPath! , at: .top, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch (indexPath.section,indexPath.row) {
            
        case (2,0):
            
            momentDescription.resignFirstResponder()
            momentName.resignFirstResponder()
            datePickerShowAnimation()
            
            //to get the date picker full view
            if mode == MomentMode.edit.rawValue {
                scrollToFirstRow()
            }
        case (3,0):
          
            guard let pushToColorsPage = storyboard?.instantiateViewController(withIdentifier: "ColorsViewController") as? ColorsViewController else {
                return
            }
            pushToColorsPage.delegate = self
            
            pushToColorsPage.selectedColor = selectedColor
            
            let navController = UINavigationController(rootViewController: pushToColorsPage)
            
            navigationController?.present(navController, animated: true, completion: nil)
            
        case (4,0):
            
            let alert = UIAlertController(title: "Delete", message: "Would you like to delete", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
            
            alert.addAction(UIAlertAction(title: "DELETE", style: UIAlertActionStyle.destructive, handler: { action in
                
                self.deleteMoment(moment: self.createdMoment!)
                
                guard let createdMoment = self.createdMoment else { return }
                
                container.viewContext.delete(createdMoment)
                
                try!   container.viewContext.save()

                self.navigationController?.popViewController(animated: true) } ))
            
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
