//
//  NameTableViewCell.swift
//  GymBro
//
//  Created by Alexander Gattringer on 22/04/16.
//  Copyright © 2016 Alexander Gattringer. All rights reserved.
//

import UIKit

protocol NameTableViewCellDelegate{
    func nameEdited(name:String)
}

class NameTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var name: UITextField!
    var delegate:NameTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        name.delegate = self
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func select(sender: AnyObject?) {
        name.becomeFirstResponder()
        self.setSelected(false, animated: true)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        delegate?.nameEdited(textField.text!)
        textField.resignFirstResponder()
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
