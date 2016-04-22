//
//  PlanTableViewCell.swift
//  GymBro
//
//  Created by Alexander Gattringer on 22/04/16.
//  Copyright © 2016 Alexander Gattringer. All rights reserved.
//

import UIKit

class PlanTableViewCell: UITableViewCell {
    static let cellHeight:CGFloat = 74
    @IBOutlet weak var exercisesCount: UILabel!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setPlan(plan: WorkoutPlan){
        name.text = plan.name
        exercisesCount.text = "\(plan.exercises.count) exercise/s in this plan"
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
