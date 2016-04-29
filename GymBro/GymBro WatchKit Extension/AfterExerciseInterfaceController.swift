//
//  AfterExerciseInterfaceController.swift
//  GymBro
//
//  Created by Alexander Gattringer on 29/04/16.
//  Copyright © 2016 Alexander Gattringer. All rights reserved.
//

import WatchKit
import Foundation


class AfterExerciseInterfaceController: WKInterfaceController {

    @IBOutlet var repetitionsPicker: WKInterfacePicker!
    var exercise:Exercise!
    var repetitions:Int = 1
    
    @IBOutlet var nextButton: WKInterfaceButton!
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        repetitionsPicker.setItems(getItemsForRepetitions())
        exercise = WorkoutController.sharedController.getCurrentExercise()
    }
    
    func getItemsForRepetitions() -> [WKPickerItem]{
        var items = [WKPickerItem]()
        
        for i in 1...50 {
            let item = WKPickerItem()
            item.title = "\(i) reps"
            items.append(item)
        }
        
        return items
    }
    
    @IBAction func pickerAction(value: Int) {
        repetitions = value
    }
    
    @IBAction func endExercise() {
        exercise.repetitions = repetitions
        WorkoutController.sharedController.insertUpdatedExercise(exercise)
        
        if (WorkoutController.sharedController.goToNextExercise()){
            //last exercise reached
            pushControllerWithName("Begin", context: nil)
            return
        }
        workoutFinishedPopUp()
    }
    
    func workoutFinishedPopUp(){
        let handler = { self.popToRootController() }
        let action1 = WKAlertAction(title: "OK", style: .Default, handler:handler)
        
        presentAlertControllerWithTitle("Workout finished", message: "You did great today!", preferredStyle: .Alert, actions: [action1])
    }
}
