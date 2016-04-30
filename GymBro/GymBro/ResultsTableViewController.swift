//
//  ViewController.swift
//  GymBro
//
//  Created by Alexander Gattringer on 15/04/16.
//  Copyright © 2016 Alexander Gattringer. All rights reserved.
//

import UIKit

class ResultsTableViewController: UITableViewController {
    let resultCellReuse = "ResultReuseIdentifier"
    var sessions:[WorkoutSession]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        let nib = UINib(nibName: "ResultTableViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: resultCellReuse)
        
        loadStoredData()
        self.tableView.reloadData()
    }
    
    func loadStoredData(){
        if let loaded = DataManager.sharedManager.loadSessions(){
            sessions = loaded
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:ResultTableViewCell = tableView.dequeueReusableCellWithIdentifier(resultCellReuse) as! ResultTableViewCell
        cell.setSession(self.sessions[indexPath.row])
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (sessions != nil){
            return sessions.count
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return ResultTableViewCell.cellHeight
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.section == 0){
            openSessionDetailView(sessions[indexPath.row])
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func openSessionDetailView(session: WorkoutSession){
        
        let sessionDetail:SessionDetailTableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SessionDetail") as! SessionDetailTableViewController
        
        sessionDetail.setCompletedExercises(session.usedPlan.exercises)
        self.navigationController?.pushViewController(sessionDetail, animated: true)
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            if (indexPath.section == 0){
                sessions.removeAtIndex(indexPath.row)
                DataManager.sharedManager.saveSessions(sessions)
                
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
        }
    }
    

}

