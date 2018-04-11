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

class DescriptionTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var descriptionTextfield: UITextField!
    
    var delegate: DescriptionTableViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        descriptionTextfield.delegate = self
    }
    
    @IBAction func descriptionAction(_ sender: UITextField) {
        delegate?.addDescription(for: self)
    }
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        delegate?.addDescription(for: self)
        return true
    }
}
