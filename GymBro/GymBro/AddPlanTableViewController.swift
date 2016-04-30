//
//  AddPlanTableViewController.swift
//  GymBro
//
//  Created by Alexander Gattringer on 22/04/16.
//  Copyright © 2016 Alexander Gattringer. All rights reserved.
//

import UIKit

class AddPlanTableViewController: UITableViewController, NameTableViewCellDelegate, ExerciseSelectionDelegate {
    let nameReuseIdentifier = "NameCellIdentifier"
    let exerciseCellReuse = "ExerciseCellIdentifier"
    let defaultCellReuse = "UITableViewCell"
    
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
        self.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: defaultCellReuse)

        createSaveButtonItem()
    }
    
    func createSaveButtonItem(){
        let saveButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save, target: self, action: "saveAndReturn")
        navigationItem.rightBarButtonItem = saveButton
    }
    
    func saveAndReturn(){
        //only save when name is longer than 0
        let name = self.currentName
        
        if (name.characters.count != 0 && exercises.count > 0) {
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
            return 2
        }
        return exercises.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.section == 0){
            if (indexPath.row == 0){
                let cell:NameTableViewCell = tableView.dequeueReusableCellWithIdentifier(nameReuseIdentifier, forIndexPath: indexPath) as! NameTableViewCell
                cell.delegate = self
                return cell
            }
            let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier(defaultCellReuse, forIndexPath: indexPath) 
            cell.accessoryType = .DisclosureIndicator
            cell.textLabel?.text = "Add exercise"
            return cell
        }
        
        let cell:ExerciseTableViewCell = tableView.dequeueReusableCellWithIdentifier(exerciseCellReuse, forIndexPath: indexPath) as! ExerciseTableViewCell
        cell.setExerciseForCell(exercises[indexPath.row])
        
        return cell

    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.section == 0 && indexPath.row == 1){
            addNewExerciseToPlan()
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.section == 0){
            return 44 //standard cell height
        }
        return ExerciseTableViewCell.cellHeight
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            if (indexPath.section == 1){
                exercises.removeAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
            
        }
    }
    
    func addNewExerciseToPlan(){
        let exerciseSelectionController:ExerciseSelectionTableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ExerciseSelection") as! ExerciseSelectionTableViewController
        exerciseSelectionController.delegate = self
        presentViewController(exerciseSelectionController, animated: true, completion: {
            self.tableView.reloadData()
        })
    }
    
    func nameEdited(name: String) {
        self.title = name
        self.currentName = name
    }
    
    func didSelectExercise(exercise: Exercise) {
        exercises.append(exercise)
        self.tableView.reloadData()
    }
}
