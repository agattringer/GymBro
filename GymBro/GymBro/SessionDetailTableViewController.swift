//
//  SessionDetailTableViewController.swift
//  GymBro
//
//  Created by Alexander Gattringer on 30/04/16.
//  Copyright © 2016 Alexander Gattringer. All rights reserved.
//

import UIKit

class SessionDetailTableViewController: UITableViewController {
        
    let exerciseCellReuse = "ExerciseCellIdentifier"
    
    var exercises:[Exercise] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "ExerciseTableViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: exerciseCellReuse)
    }
    
    func setCompletedExercises(exercises:[Exercise]){
        self.exercises = exercises
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:ExerciseTableViewCell = tableView.dequeueReusableCellWithIdentifier(exerciseCellReuse) as! ExerciseTableViewCell
        cell.setExerciseForCell(self.exercises[indexPath.row])
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return ExerciseTableViewCell.cellHeight
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}
