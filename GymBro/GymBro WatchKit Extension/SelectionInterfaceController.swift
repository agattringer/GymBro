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
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
    }
    
    override func willActivate() {
        planPicker.setItems(DataManager.sharedManager.loadWorkoutPlanPickerItems())
        WorkoutController.sharedController.startWorkoutWithIndex(0)
    }
    
    
    @IBAction func pickerAction(value: Int) {
        WorkoutController.sharedController.startWorkoutWithIndex(value)
    }

}
