//
//  SelectionInterfaceController.swift
//  GymBro
//
//  Created by Alexander Gattringer on 29/04/16.
//  Copyright © 2016 Alexander Gattringer. All rights reserved.
//

import WatchKit
import Foundation


class SelectionInterfaceController: WKInterfaceController {

    @IBOutlet var planPicker: WKInterfacePicker!
    @IBOutlet var start: WKInterfaceButton!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
    }
    
    override func willActivate() {
        WorkoutController.sharedController.startWorkoutWithIndex(0)
        if (DataManager.sharedManager.loadWorkoutPlans() == nil){
            //deactivate start button -> no plans yet
            start.setEnabled(false)
        }else{
            start.setEnabled(true)
        }
        planPicker.setItems(DataManager.sharedManager.loadWorkoutPlanPickerItems())
    }
    
    
    @IBAction func pickerAction(value: Int) {
        WorkoutController.sharedController.startWorkoutWithIndex(value)
    }

}
