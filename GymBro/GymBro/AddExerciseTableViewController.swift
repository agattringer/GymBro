//
//  AddExerciseTableViewController.swift
//  GymBro
//
//  Created by Alexander Gattringer on 22/04/16.
//  Copyright © 2016 Alexander Gattringer. All rights reserved.
//

import UIKit

class AddExerciseTableViewController: UITableViewController {

    @IBOutlet weak var name: UITextField!
    
    var currentIntensity:ExerciseIntensity = ExerciseIntensity.Medium
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSaveButtonItem()
        self.title = "Add exercise"
    }
    
    func createSaveButtonItem(){
        let saveButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save, target: self, action: "saveAndReturn")
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @IBAction func intensityChanged(sender: UISegmentedControl) {
        switch (sender.selectedSegmentIndex){
        case 0:
            currentIntensity = ExerciseIntensity.Low
        case 1:
            currentIntensity = ExerciseIntensity.Medium
        case 2:
            currentIntensity = ExerciseIntensity.High
        default:
            currentIntensity = ExerciseIntensity.Medium
        }
    }
    
    func saveAndReturn(){
        //only save when name is longer than 0
        let name = self.name.text
        
        if (name?.characters.count != 0){
            DataManager.sharedManager.saveExercise(Exercise(name: name!, intensity: self.currentIntensity))
            navigationController?.popViewControllerAnimated(true)
        }else{
            let errorAlert = UIAlertController(title: "No name specified", message: "Please enter a name to save this exercise", preferredStyle: UIAlertControllerStyle.Alert)
            
            errorAlert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: { (action: UIAlertAction!) in
                errorAlert.dismissViewControllerAnimated(true, completion: nil)
            }))
            
            presentViewController(errorAlert, animated: true, completion: nil)
        }


    }

}
