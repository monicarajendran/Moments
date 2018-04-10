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
    
    @IBOutlet weak var blue: UILabel!
    
    @IBOutlet weak var brown: UILabel!
    
    @IBOutlet weak var pink: UILabel!
    
    @IBOutlet weak var indigo: UILabel!
    
    @IBOutlet weak var teal: UILabel!
    
    @IBOutlet weak var cyan: UILabel!
    
    @IBOutlet weak var pestoGreen: UILabel!
    
    @IBOutlet weak var purple: UILabel!
    
    @IBOutlet weak var lightGreen: UILabel!
    
    @IBOutlet weak var orange: UILabel!
    
    @IBOutlet weak var gray: UILabel!
        
    var delegate : ColorsViewControllerDelegate?
    
    var selectedColor : MomentColors?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Choose Color"
        
        UIApplication.shared.statusBarStyle = .default
        self.navigationController?.navigationBar.isHidden = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(ColorsViewController.close))
        
        let arrayOfLabels = [blue,brown,pink,indigo,teal,cyan,pestoGreen,purple,lightGreen,orange,gray]
        
        for index in 0..<arrayOfLabels.count{
            circleShapeForLabel(label: arrayOfLabels[index]!)
        }
        tableView.tableFooterView = UIView()
    }
    
    @objc func close () {
        self.navigationController?.popViewController(animated: true)

    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if selectedColor?.hashValue == indexPath.row {
            cell.accessoryType = .checkmark
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        close()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let color = MomentColors.allCases[indexPath.row]
        delegate?.selectedColor(color: color)
        close()
    }
}
