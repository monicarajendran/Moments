//
//  ColorsPage.swift
//  Moments
//
//  Created by user on 02/11/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit

protocol ColorsViewControllerDelegate {
    
    func selectedColor(color: MomentColors)
}

class ColorsViewController: UITableViewController {
    
    
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
    
    @IBOutlet weak var gray: UILabel!
        
    var delegate : ColorsViewControllerDelegate?
    
    var selectedColor : MomentColors?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Choose Color"
        
        
        let arrayOfLabels = [red,blue,pink,indigo,teal,cyan,pestoGreen,purple,lime,orange,gray]
        
        for i in 0..<arrayOfLabels.count{
            
            circleShapeForLabel(label: arrayOfLabels[i]!)
            
        }
        
        themeColors()
        
        tableView.tableFooterView = UIView()
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if selectedColor?.hashValue == indexPath.row {
            cell.accessoryType = .checkmark
        }
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let color = MomentColors.allCases[indexPath.row]
        
        delegate?.selectedColor(color: color)
        
        dismiss(animated: true, completion: nil)
        
    }
}
