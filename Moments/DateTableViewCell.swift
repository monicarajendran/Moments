//
//  DateTableViewCell.swift
//  Moments
//
//  Created by Monica on 04/04/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
protocol DateTableviewDelegate {
    func chooseADate(for cell: DateTableViewCell)
}
class DateTableViewCell: UITableViewCell {

    var delegate: DateTableviewDelegate?

    @IBOutlet weak var dateTitle: UIButton! {
        didSet {
            dateTitle.titleLabel?.font = AppFont.regular(size: 17)
        }
    }
    
    @IBAction func chooseDateAction(_ sender: Any) {
        delegate?.chooseADate(for: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
