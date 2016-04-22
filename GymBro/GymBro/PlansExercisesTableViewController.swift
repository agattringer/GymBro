//
//  PlansExercisesTableViewController.swift
//  GymBro
//
//  Created by Alexander Gattringer on 22/04/16.
//  Copyright © 2016 Alexander Gattringer. All rights reserved.
//

import UIKit

class PlansExercisesTableViewController: UITableViewController{
    let exerciseCellReuse = "ExerciseCellIdentifier"
    let planCellReuse = "PlanCellIdentifier"
    
    let showNewExerciseSegue = "showNewExercise"
    let showNewPlanSegue = "showNewPlan"
    
    var exercises:[Exercise] = []
    var plans:[WorkoutPlan] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
        var nib = UINib(nibName: "ExerciseTableViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: exerciseCellReuse)
        nib = UINib(nibName: "PlanTableViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: planCellReuse)
        
        loadStoredData()
        tableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadStoredData()
        tableView.reloadData()
    }
    
    func loadStoredData(){
        if let loaded = DataManager.sharedManager.loadExercises(){
            exercises = loaded
        }
        if let loaded = DataManager.sharedManager.loadWorkoutPlans(){
            plans = loaded
        }
    }
    
    func addExercise(){
        self.performSegueWithIdentifier(showNewExerciseSegue, sender: self)
    }
    
    func addPlan(){
        self.performSegueWithIdentifier(showNewPlanSegue, sender: self)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.section == 1){
          let cell:ExerciseTableViewCell = tableView.dequeueReusableCellWithIdentifier(exerciseCellReuse) as! ExerciseTableViewCell
            cell.setExercise(self.exercises[indexPath.row])
            return cell
        }
        let cell:PlanTableViewCell = tableView.dequeueReusableCellWithIdentifier(planCellReuse) as! PlanTableViewCell
        cell.setPlan(self.plans[indexPath.row])
        
        return cell
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0){
            return plans.count
        }
        return exercises.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.section == 0){
            return PlanTableViewCell.cellHeight
        }
        return ExerciseTableViewCell.cellHeight
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0){
            return "Workout plans"
        }
        return "Exercises"
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            if (indexPath.section == 0){
                plans.removeAtIndex(indexPath.row)
            }else{
                exercises.removeAtIndex(indexPath.row)
                DataManager.sharedManager.saveExercises(exercises)
            }
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    @IBAction func addPressed(sender: AnyObject) {
        createAndShowSelectionDialog()
    }
    
    func createAndShowSelectionDialog(){
        let selectionAlert = UIAlertController(title: "What to add?", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        selectionAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action: UIAlertAction!) in
            selectionAlert.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        selectionAlert.addAction(UIAlertAction(title: "Add exercise", style: .Default, handler: { (action: UIAlertAction!) in
            self.addExercise()
        }))
        
        selectionAlert.addAction(UIAlertAction(title: "Add plan", style: .Default, handler: { (action: UIAlertAction!) in
            self.addPlan()
        }))
        
        presentViewController(selectionAlert, animated: true, completion: nil)
    }
}
