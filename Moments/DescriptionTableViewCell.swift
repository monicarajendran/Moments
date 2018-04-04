//
//  CreateMomentTableViewCell.swift
//  Moments
//
//  Created by Monica on 04/04/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

protocol DescriptionTableViewDelegate {
    func addDescription(for cell: DescriptionTableViewCell)
}

class DescriptionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var descriptionTextfield: UITextField!
    
    var delegate: DescriptionTableViewDelegate?
    
    @IBAction func descriptionAction(_ sender: UITextField) {
        delegate?.addDescription(for: self)
    }
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
