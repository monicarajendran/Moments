//
//  DetailsViewController.swift
//  Moments
//
//  Created by Monica on 04/04/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import Apploader

class DetailsViewController: UIViewController {

    @IBOutlet weak var editButtonOutlet: UIButton!
    @IBOutlet weak var momentTitle: UILabel!
    @IBOutlet weak var momentDesc: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var topview: UIView!
    
    var selectedMoment: Moment?
    var alertHud: MBProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        UIApplication.shared.statusBarStyle = .lightContent
        editButtonOutlet.layer.cornerRadius = editButtonOutlet.frame.width / 2
        editButtonOutlet.layer.shadowOffset = CGSize(width: 12, height: 10)
        editButtonOutlet.layer.shadowColor = UIColor.black.cgColor
        editButtonOutlet.layer.shadowOpacity = 0.7
        editButtonOutlet.layer.shadowRadius = 25.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        displayDetailsOfMoment()
        alertHud = getAlertHUD(srcView: self.view)
    }
    
    func displayDetailsOfMoment() {
        momentTitle.text = selectedMoment?.name
        momentDesc.text = selectedMoment?.desc
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = MomentDateFormat.long.rawValue
        date.text = dateFormat.string(from: (selectedMoment?.momentTime.toDate) ?? Date())
        
        let momentColor: UIColor = UIColor(hexString: selectedMoment?.color ?? MomentColors.red.rawValue)
        
        editButtonOutlet.backgroundColor = momentColor
        
        topview.backgroundColor = momentColor
    }

    @IBAction func editAction(_ sender: UIButton) {
        guard let createPageVc = R.storyboard.main.createMomentsViewController() as? CreateMomentsViewController else {
            return
        }
        createPageVc.momentMode = .edit
        createPageVc.toEditMoment = selectedMoment
        navigationController?.pushViewController(createPageVc, animated: true)
    }
    
    @IBAction func closePage(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func moreButton(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in self.deleteMoment() }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func deleteMoment  () {
        
        let alert = UIAlertController(title: "Would you like to delete", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { action in
            
            guard let moment = self.selectedMoment else { return }
            
            container.viewContext.delete(moment)
            try!   container.viewContext.save()
            
            self.alertHud.showText(msg: "Moment deleted successfully", detailMsg: "", delay: 1)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                _ = self.navigationController?.popToRootViewController(animated: true) })
            
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
    
        self.present(alert, animated: true, completion: nil)

    }
}
