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
    @IBOutlet weak var repetitions: UILabel!
    @IBOutlet weak var weight: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setExerciseForCell(exercise: Exercise){
        name.text = exercise.name
        intensity.text = "Intensity: " + exercise.intensity.rawValue
        if (exercise.repetitions > 0){
            repetitions.text = "\(exercise.repetitions) reps"
        }else{
            repetitions.text = ""
        }
        if (exercise.weight > 0){
            weight.text = "\(exercise.weight) kg"
        }else{
            weight.text = ""
        }
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
