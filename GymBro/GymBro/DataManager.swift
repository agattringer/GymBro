//
//  DataManager.swift
//  GymBro
//
//  Created by Alexander Gattringer on 15/04/16.
//  Copyright © 2016 Alexander Gattringer. All rights reserved.
//

import UIKit

class DataManager: NSObject {
    //singleton
    static let sharedManager = DataManager()
    
    var documentsDirectory:NSURL!
    var workoutPlansURL:NSURL!
    var exercisesURL:NSURL!
    var savedSessionsURL:NSURL!
    
    
    //This prevents others from using the default '()' initializer for this class.
    private override init() {
        documentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
        workoutPlansURL = documentsDirectory.URLByAppendingPathComponent("workoutPlans")
        exercisesURL = documentsDirectory.URLByAppendingPathComponent("exercises")
        savedSessionsURL = documentsDirectory.URLByAppendingPathComponent("savedSessions")
    }
    
    func saveSession(session: WorkoutSession){
        var sessions = [WorkoutSession]()
        
        if let loaded = loadSessions(){
            sessions.appendContentsOf(loaded)
        }
        sessions.append(session)
        NSKeyedArchiver.archiveRootObject(sessions, toFile: savedSessionsURL.path!)
    }
    
    func loadSessions() -> [WorkoutSession]?{
        return NSKeyedUnarchiver.unarchiveObjectWithFile(savedSessionsURL.path!) as? [WorkoutSession]
    }
    
    func saveExercise(exercise: Exercise){
        var exercises = [Exercise]()
        
        if let loaded = loadExercises(){
            exercises.appendContentsOf(loaded)
        }
        exercises.append(exercise)
        
        saveExercises(exercises)
    }
    
    func saveExercises(exercises: [Exercise]){
        NSKeyedArchiver.archiveRootObject(exercises, toFile: exercisesURL.path!)
    }
    
//    func deleteExercise(exercise: Exercise){
//        if var exercises = loadExercises(){
//            if let index = exercises.indexOf(exercise){
//                exercises.removeAtIndex(index)
//                NSKeyedArchiver.archiveRootObject(exercises, toFile: exercisesURL.path!)
//            }
//        }
//    }
    
    func loadExercises() -> [Exercise]?{
        return NSKeyedUnarchiver.unarchiveObjectWithFile(exercisesURL.path!) as? [Exercise]
    }
    
    func saveWorkoutPlan(plan: WorkoutPlan){
        var workoutPlans = [WorkoutPlan]()
        
        if let loaded = loadWorkoutPlans(){
            workoutPlans.appendContentsOf(loaded)
        }
        workoutPlans.append(plan)
        
        NSKeyedArchiver.archiveRootObject(workoutPlans, toFile: workoutPlansURL.path!)
    }
    
    func deleteWorkoutPlan(plan: WorkoutPlan){
        if var workoutPlans = loadWorkoutPlans(){
            if let index = workoutPlans.indexOf(plan){
                workoutPlans.removeAtIndex(index)
                NSKeyedArchiver.archiveRootObject(workoutPlans, toFile: workoutPlansURL.path!)
            }
        }
    }
    
    func loadWorkoutPlans() -> [WorkoutPlan]?{
        return NSKeyedUnarchiver.unarchiveObjectWithFile(workoutPlansURL.path!) as? [WorkoutPlan]
    }
}
