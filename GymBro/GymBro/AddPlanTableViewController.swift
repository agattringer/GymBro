//
//  AddPlanTableViewController.swift
//  GymBro
//
//  Created by Alexander Gattringer on 22/04/16.
//  Copyright © 2016 Alexander Gattringer. All rights reserved.
//

import UIKit

class AddPlanTableViewController: UITableViewController, NameTableViewCellDelegate {
    let nameReuseIdentifier = "NameCellIdentifier"
    let exerciseCellReuse = "ExerciseCellIdentifier"
    
    var exercises:[Exercise] = []
    var currentName:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add plan"
        
        // Do any additional setup after loading the view, typically from a nib.
        var nib = UINib(nibName: "ExerciseTableViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: exerciseCellReuse)
        nib = UINib(nibName: "NameTableViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: nameReuseIdentifier)

        createSaveButtonItem()
    }
    
    func createSaveButtonItem(){
        let saveButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save, target: self, action: "saveAndReturn")
        navigationItem.rightBarButtonItem = saveButton
    }
    
    func saveAndReturn(){
        //only save when name is longer than 0
        let name = self.currentName
        
        if (name.characters.count != 0 || exercises.count > 0) {
            DataManager.sharedManager.saveWorkoutPlan(WorkoutPlan(name: name, exercises: self.exercises))
            navigationController?.popViewControllerAnimated(true)
        }else{
            let errorAlert = UIAlertController(title: "No name or exercises specified", message: "Please enter a name or add exercises to save this workout plan", preferredStyle: UIAlertControllerStyle.Alert)
            
            errorAlert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: { (action: UIAlertAction!) in
                errorAlert.dismissViewControllerAnimated(true, completion: nil)
            }))
            
            presentViewController(errorAlert, animated: true, completion: nil)
        }
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0){
            return 1
        }
        return exercises.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.section == 0){
            let cell:NameTableViewCell = tableView.dequeueReusableCellWithIdentifier(nameReuseIdentifier, forIndexPath: indexPath) as! NameTableViewCell
            cell.delegate = self
            return cell
        }
        
        let cell:ExerciseTableViewCell = tableView.dequeueReusableCellWithIdentifier(exerciseCellReuse, forIndexPath: indexPath) as! ExerciseTableViewCell
        cell.setExercise(exercises[indexPath.row])
        
        return cell

    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.row == 0){
            return 44 //standard cell height
        }
        return ExerciseTableViewCell.cellHeight
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    func nameEdited(name: String) {
        self.title = name
        self.currentName = name
    }
}
