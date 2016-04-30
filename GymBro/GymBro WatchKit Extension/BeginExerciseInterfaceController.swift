//
//  BeginExerciseInterfaceController.swift
//  GymBro
//
//  Created by Alexander Gattringer on 29/04/16.
//  Copyright © 2016 Alexander Gattringer. All rights reserved.
//

import WatchKit
import Foundation


class BeginExerciseInterfaceController: WKInterfaceController {
    @IBOutlet var exerciseName: WKInterfaceLabel!
    @IBOutlet var weightPicker: WKInterfacePicker!
    @IBOutlet var intensity: WKInterfaceLabel!
    
    var exercise:Exercise!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        exercise = WorkoutController.sharedController.getCurrentExercise()
        
        weightPicker.setItems(getItemsForWeight())
        exerciseName.setText(exercise.name)
        intensity.setText(exercise.intensity.rawValue)
        exercise.weight = 1
    }
    
    @IBAction func pickerAction(value: Int) {
        exercise.weight = value
    }
    
    @IBAction func startExercise(){
        WorkoutController.sharedController.insertUpdatedExercise(exercise)
    }
    
    func getItemsForWeight() -> [WKPickerItem]{
        var items = [WKPickerItem]()
        
        for i in 1...100 {
            let item = WKPickerItem()
            item.title = "\(i) kg"
            items.append(item)
        }
        
        return items
    }
}
