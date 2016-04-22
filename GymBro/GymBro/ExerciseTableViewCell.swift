//
//  ExerciseTableViewCell.swift
//  GymBro
//
//  Created by Alexander Gattringer on 22/04/16.
//  Copyright © 2016 Alexander Gattringer. All rights reserved.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {
    static let cellHeight:CGFloat = 74
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var intensity: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setExercise(exercise: Exercise){
        name.text = exercise.name
        intensity.text = "Intensity: " + exercise.intensity.rawValue
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
