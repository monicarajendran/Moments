//
//  DetailsViewController.swift
//  Moments
//
//  Created by Monica on 04/04/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import CloudKit
import Apploader

class AppWithOutNavBarView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)    
        if self.navigationController?.viewControllers.last != self {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

class DetailsViewController: UIViewController {

    @IBOutlet weak var editButtonOutlet: UIButton!
    @IBOutlet weak var momentTitle: UILabel! {
        didSet {
            momentTitle.font = AppFont.medium(size: 30)
        }
    }
    @IBOutlet weak var momentDesc: UILabel! {
        didSet {
            momentDesc.font = AppFont.regular(size: 18)
        }
    }
    @IBOutlet weak var date: UILabel! {
        didSet {
            date.font = AppFont.regular(size: 18)
        }
    }
    @IBOutlet weak var topview: UIView! 
    
    var selectedMoment: Moment?
    var alertHud: MBProgressHUD!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        UIApplication.shared.statusBarStyle = .lightContent
        addShadow()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        displayDetails()
//        print("Moment Id-----", selectedMoment?.momentId ,"\n", "Moment Name------", selectedMoment?.name,"\n","Moment Desc-----", selectedMoment?.desc,"\n", "Moment color-----", selectedMoment?.color,"\n", "Moment Time-----",selectedMoment?.momentTime,"\n", "Moment Date-----", selectedMoment?.momentDate,"\n","Moment Day-----", selectedMoment?.day,"\n", "Moment Month-----", selectedMoment?.month)
        
        alertHud = getAlertHUD(srcView: self.view)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    
    func addShadow () {
        
        editButtonOutlet.layer.cornerRadius = editButtonOutlet.frame.width / 2
        editButtonOutlet.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        editButtonOutlet.layer.shadowOffset = CGSize(width: 0, height: 1)
        editButtonOutlet.layer.shadowOpacity = 1
        editButtonOutlet.layer.shadowRadius = 5
        editButtonOutlet.layer.masksToBounds = false
    }
    
    func displayDetails() {
        
        momentTitle.text = selectedMoment?.name
        momentDesc.text = selectedMoment?.desc
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = MomentDateFormat.long.rawValue
        date.text = dateFormat.string(from: (selectedMoment?.momentTime.toDate) ?? Date())
        
        let momentColor: UIColor = UIColor(hexString: selectedMoment?.color ?? MomentColors.blue.rawValue)
        editButtonOutlet.backgroundColor = momentColor
        topview.backgroundColor = momentColor
    }

    @IBAction func editAction(_ sender: UIButton) {
        guard let createPageVc = R.storyboard.main.createMomentsViewController() else {
            return
        }
        createPageVc.momentMode = .edit
        createPageVc.editMomentObj = selectedMoment
        navigationController?.pushViewController(createPageVc, animated: true)
    }
    
    @IBAction func closePage(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func moreButton(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in self.deleteMoment() }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func deleteMoment() {
        
        let alert = UIAlertController(title: "Would you like to delete", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { action in
            
            guard let moment = self.selectedMoment else { return }
            
            //Delete the moment first in iCLoud to have the reference of moment  
            let recordId = CKRecordID(recordName: moment.momentId!)
            CloudSyncServices.deleteICloudMoment(recordId: recordId)
            
            container.viewContext.delete(moment)
            try!   container.viewContext.save()
            
            self.alertHud.showText(msg: "Moment deleted successfully", detailMsg: "", delay: 1)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                _ = self.navigationController?.popToRootViewController(animated: true) })
            
        }))
        
        //Delete the moment first in iCLoud to have the reference of moment
        let recordId = CKRecordID(recordName: selectedMoment!.momentId!)
        CloudSyncServices.deleteICloudMoment(recordId: recordId)
        
        container.viewContext.delete(selectedMoment!)
        try!   container.viewContext.save()
        
        self.alertHud.showText(msg: "Moment deleted successfully", detailMsg: "", delay: 1)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            _ = self.navigationController?.popToRootViewController(animated: true)
        })
    }
}
