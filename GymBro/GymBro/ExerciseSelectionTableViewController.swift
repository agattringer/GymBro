//
//  ExerciseSelectionTableViewController.swift
//  GymBro
//
//  Created by Alexander Gattringer on 29/04/16.
//  Copyright © 2016 Alexander Gattringer. All rights reserved.
//

import UIKit

protocol ExerciseSelectionDelegate{
    func didSelectExercise(exercise: Exercise)
}

class ExerciseSelectionTableViewController: UITableViewController {
    let exerciseCellReuse = "ExerciseCellIdentifier"
    
    var delegate:ExerciseSelectionDelegate?
    var exercises:[Exercise] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "ExerciseTableViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: exerciseCellReuse)
        
        loadStoredData()
        tableView.reloadData()
    }

    func loadStoredData(){
        if let loaded = DataManager.sharedManager.loadExercises(){
            exercises = loaded
        }
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell:ExerciseTableViewCell = tableView.dequeueReusableCellWithIdentifier(exerciseCellReuse) as! ExerciseTableViewCell
        cell.setExercise(self.exercises[indexPath.row])
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return ExerciseTableViewCell.cellHeight
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        delegate?.didSelectExercise(exercises[indexPath.row])
        dismissViewControllerAnimated(true, completion: nil)
    }
}
