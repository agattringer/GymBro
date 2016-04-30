//
//  ResultTableViewCell.swift
//  GymBro
//
//  Created by Alexander Gattringer on 30/04/16.
//  Copyright © 2016 Alexander Gattringer. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    static let cellHeight:CGFloat = 69
    @IBOutlet weak var plan: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var exercises: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setSession(session:WorkoutSession){
        plan.text = "Plan: \(session.usedPlan.name)"
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.MediumStyle
        formatter.timeStyle = .NoStyle
        
        date.text = "Date: \(formatter.stringFromDate(session.date))"
        
        exercises.text = "\(session.usedPlan.exercises.count) exercise/s"
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
