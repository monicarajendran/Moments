//
//  ColorsPage.swift
//  Moments
//
//  Created by user on 02/11/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit

class ColorsPageViewController: UITableViewController {
    
    
    @IBOutlet weak var red: UILabel!

    @IBOutlet weak var blue: UILabel!
    
    @IBOutlet weak var pink: UILabel!
    
    @IBOutlet weak var indigo: UILabel!
    
    @IBOutlet weak var teal: UILabel!
    
    @IBOutlet weak var cyan: UILabel!
    
    @IBOutlet weak var pestoGreen: UILabel!
    
    @IBOutlet weak var purple: UILabel!
    
    @IBOutlet weak var lime: UILabel!
    
    @IBOutlet weak var orange: UILabel!
    
    @IBOutlet weak var none: UILabel!
    
    var label : UILabel!
    
    func showAlert(){
        
        label = UILabel(frame: CGRect(x: 100, y: 5, width: 200, height: 15))
        label.layer.backgroundColor = UIColor.brown.cgColor
        label.alpha = 0.7
        
        label.text = "Theme Color Updated!"
        label.textColor = .white
        self.view.addSubview(label)

        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.dismissAlert), userInfo: nil, repeats: true)
    }
    
    func dismissAlert(){
    
    label.removeFromSuperview()
    
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Choose Color"
        
        themeColors()
        
        circleShape()
        

        tableView.tableFooterView = UIView()
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       let hexaColor = NewMomentsPageViewController.hexaStringColor(index: indexPath.row)
        
        UserDefaults.standard.set(hexaColor, forKey: "colorChosen")
        showAlert()
    }


}
