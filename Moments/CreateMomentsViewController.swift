//
//  CreateMomentsViewController.swift
//  Moments
//
//  Created by Monica on 02/04/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import CloudKit
import Apploader
import SnapKit
import ActionSheetPicker_3_0

class CreateMomentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DescriptionTableViewDelegate, DateTableviewDelegate, ColorTableViewCellDelegate, UITextFieldDelegate, ColorsViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var createPageTopView: UIView!
    @IBOutlet weak var momentNameTextfield: UITextField! {
        didSet {
            momentNameTextfield.font = AppFont.medium(size: 20)
        }
    }
    
    var alterHud: MBProgressHUD!
    var momentDescrption: String = ""
    var momentDate: Date = Date()
    let dateFormatter = DateFormatter()
    var selectedColor : MomentColors?
    var editMomentObj: Moment?
    
    weak var momentDelegate: MomentDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if MOMENT_MODE == .edit {
            
            momentNameTextfield.text = editMomentObj?.name
            momentDescrption = editMomentObj?.desc ?? ""
            self.momentNameTextfield.resignFirstResponder()
            selectedColor = MomentColors(rawValue: (editMomentObj?.color) ?? MomentColors.blue.rawValue)
            momentDate = editMomentObj?.momentTime.toDate ?? Date()
            dateFormatter.dateFormat = MomentDateFormat.short.rawValue
            createPageTopView.backgroundColor = UIColor(hexString: editMomentObj?.color ?? MomentColors.blue.rawValue)
            
        } else {
            selectedColor = MomentColors.blue
            self.momentNameTextfield.becomeFirstResponder()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.isHidden = true
        setupView()
        alterHud = getAlertHUD(srcView: self.view)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.descriptionCell, for: indexPath)! 
            cell.delegate = self
            
            if MOMENT_MODE == .create {
                momentDescrption = cell.descTextView.text!
            } else {
                cell.descTextView.text = momentDescrption
            }
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.dateCell, for: indexPath)!
            cell.delegate = self
            if MOMENT_MODE == .edit {
                cell.dateTitle.setTitle(dateFormatter.string(from: momentDate), for: .normal)
            }
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.colorCell, for: indexPath)!
            cell.delegate = self
            cell.colorLabel.backgroundColor = UIColor(hexString: selectedColor?.rawValue ?? MomentColors.blue.rawValue)
            cell.colorLabel.layer.cornerRadius = cell.colorLabel.frame.width / 2
            cell.colorButtonTitle.setTitle(selectedColor?.name ?? "Default Color", for: .normal)
            
            return cell
            
        default:
            return tableView.dequeueReusableCell(withIdentifier: "descriptionCell", for: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func addDescription(for cell: DescriptionTableViewCell) {
        momentDescrption = cell.descTextView.text!.capitalized
    }
    
    func chooseADate(for cell: DateTableViewCell) {

        view.endEditing(true)
        
        let datePicker = ActionSheetDatePicker(title: "", datePickerMode: UIDatePickerMode.date, selectedDate: NSDate() as Date?, doneBlock: {
            picker, date, index in
            
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            self.momentDate = date as! Date
            self.dateFormatter.dateFormat = MomentDateFormat.short.rawValue
            cell.dateTitle.setTitle(self.dateFormatter.string(from: self.momentDate), for: .normal)
            
            return
            
        }, cancel: { ActionStringCancelBlock in return }, origin: tableView.superview)
        
        datePicker?.show()
    }
    
    func colorAction(for cell: ColorTableViewCell) {
        view.endEditing(true)
        
        guard let colorsVC = R.storyboard.main.colorsViewController() else {
            return
        }
        colorsVC.delegate = self
        colorsVC.selectedColor = selectedColor
        
        navigationController?.pushViewController(colorsVC, animated: true)
    }
    
    func selectedColor(color: MomentColors) {
        selectedColor = color
    }
    
    func setupView() {
        
        UIApplication.shared.statusBarStyle = .lightContent
        tableView.tableFooterView = UIView(frame: .zero)
        createPageTopView.backgroundColor = UIColor(hexString: selectedColor?.rawValue ?? MomentColors.blue.rawValue)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let descriptionCell = tableView.cellForRow(at: [0,0]) as! DescriptionTableViewCell
        
        switch textField {
            
        case momentNameTextfield:
            descriptionCell.descTextView.becomeFirstResponder()
            
        default:
            print("Textfield return functuion breaks")
        }
        return false
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        close()
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
       
        if MOMENT_MODE == .create {
            createMoment(sender: sender)
        } else {
            editMoment()
        }
    }
    
    func saveMoment(moment: Moment) -> Moment{
        
        moment.name = momentNameTextfield.text
        moment.desc = momentDescrption
        moment.color = self.selectedColor?.rawValue ?? MomentColors.blue.rawValue
        moment.year = momentDate.year.int16Value

        self.dateFormatter.dateStyle = .long
        let seconds = momentDate.timeIntervalSince1970//self.datePicker.date.timeIntervalSince1970
        let momentTime = Int64(seconds)
        
        moment.momentTime = momentTime
        //Moment timeline Card day
        dateFormatter.dateFormat = MomentDateFormat.date.rawValue
        moment.day = Int16(self.dateFormatter.string(from: momentDate))!
        
        moment.momentDate = momentTime.toDate.startOfDay
        moment.momentMonth = momentTime.toDate.prevMonth.nextMonth(at: .start)
        moment.momentWeek = momentTime.toDate.startWeek
        moment.momentYear = momentDate.year.int16Value
        
        let currentDate = Date().timeIntervalSince1970
        moment.createdAt = Int64(currentDate)
        moment.modifiedAt = Int64(currentDate)
        
        let timeString = self.dateFormatter.string(from: momentDate)
        moment.searchToken = [momentNameTextfield.text!, " ", momentDescrption, " ", timeString].joined()
                
        do {
            try container.viewContext.save()
        }
        catch{
            print("Error:",error)
        }
        tableView.reloadData()
        return moment
    }
    
    func  createMoment(sender: UIButton) {
        
        guard let momentName = momentNameTextfield.text , !momentName.isEmpty   else {
            alterHud.showText(msg: "Title is Required", detailMsg: "", delay: 1)
            return
        }
        var moment = container.viewContext.moment.create()
        moment.momentId = NSUUID().uuidString
        moment = saveMoment(moment: moment)
        
        CloudSyncServices.addRecordToIColud(record: moment.toICloudRecord())
        alterHud.showText(msg: "Moment Created Successfully!", detailMsg: "", delay: 1)
        momentDelegate?.createdMoment()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {  self.close()  } )
        
    }
    
    func editMoment() {
        
        let editedMoment = saveMoment(moment: editMomentObj!)
        updateICloud(moment: editedMoment)
        alterHud.showText(msg: "Changes saved successfully", detailMsg: "", delay: 1)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.close()})
    }
    
    func updateICloud(moment: Moment) {
        
        /// have check return
        
        CloudSyncServices.privateDb.fetch(withRecordID: CKRecordID(recordName: moment.momentId!)) { (record, error) in
            
            guard let record = record else {
                    print("error in updating the record", error as Any)
                    return
            }
            moment.updateICloudRecord(record: record)
            CloudSyncServices.addRecordToIColud(record: record)
        }
    }
    
    func deleteICloud(moment: Moment){
        
        CloudSyncServices.privateDb.delete(withRecordID: CKRecordID(recordName: moment.momentId!), completionHandler: { rec , err in
            guard let record = rec else {
                print("oopssss",err as Any)
                return
            }
            print("successfully deleted",record)
        })
    }
    
    func close() {
        
        momentNameTextfield.resignFirstResponder()
        
        if MOMENT_MODE == .create {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}
