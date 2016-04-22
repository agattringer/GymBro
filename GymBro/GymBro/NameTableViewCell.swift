//
//  NameTableViewCell.swift
//  GymBro
//
//  Created by Alexander Gattringer on 22/04/16.
//  Copyright © 2016 Alexander Gattringer. All rights reserved.
//

import UIKit

class NameTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
    
    func getName() -> String{
        if (name.text?.characters.count <= 0){
            return ""
        }else{
            return name.text!
        }
    }
    
}
