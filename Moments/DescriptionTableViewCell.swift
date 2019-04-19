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

class DescriptionTableViewCell: UITableViewCell, UITextViewDelegate {
    
    var delegate: DescriptionTableViewDelegate?
    
    @IBOutlet weak var descTextView: UITextView! {
        didSet {

            descTextView.text = "Add Description..."
            descTextView.font = AppFont.regular(size: 16)
            descTextView.textContainer.maximumNumberOfLines = 2
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        descTextView.delegate = self
        
        if MOMENT_MODE == .create {
            descTextView.textColor = .lightGray
        } else {
            descTextView.textColor = .black
            descTextView.alpha = 0.8
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if MOMENT_MODE == .create {
            if descTextView.textColor == .lightGray &&  descTextView.isFirstResponder {
                descTextView.text = nil
                descTextView.textColor = .black
                delegate?.addDescription(for: self)
            }
        } else {
            descTextView.textColor = .black
            descTextView.alpha = 0.8
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if MOMENT_MODE == .create {
            if descTextView.text.isEmpty || descTextView.text == "" {
                descTextView.textColor = .lightGray
                descTextView.text = "Add Description..."
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        delegate?.addDescription(for: self)
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
