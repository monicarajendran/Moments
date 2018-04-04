//
//  ColorTableViewCell.swift
//  Moments
//
//  Created by Monica on 04/04/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

protocol ColorTableViewCellDelegate{
    
    func colorAction(for cell: ColorTableViewCell)
}

class ColorTableViewCell: UITableViewCell {

    var delegate: ColorTableViewCellDelegate?
    
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var colorButtonTitle: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        colorLabel.layer.cornerRadius = colorLabel.frame.size.width / 2

    }
    
    @IBAction func chooseColorAction(_ sender: UIButton) {
        delegate?.colorAction(for: self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
