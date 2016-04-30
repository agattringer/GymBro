//
//  WorkoutController.swift
//  GymBro
//
//  Created by Alexander Gattringer on 29/04/16.
//  Copyright © 2016 Alexander Gattringer. All rights reserved.
//

import WatchKit

class WorkoutController: NSObject {
    static let sharedController = WorkoutController()
    
    var currentWorkout: WorkoutPlan = WorkoutPlan()
    var exerciseIndex: Int = 0;
    
    //This prevents others from using the default '()' initializer for this class.
    private override init() {
        super.init()
    }
    
    func saveFinishedWorkoutToSession(){
        let session = WorkoutSession(date: NSDate(), plan: currentWorkout)
        DataManager.sharedManager.saveSession(session)
    }
    
    func startWorkoutWithIndex(index: Int){
        if let plans = DataManager.sharedManager.loadWorkoutPlans(){
            if index < plans.count{
                currentWorkout = plans[index]
            }
        }
        exerciseIndex = 0
    }
    
    func getCurrentExercise() -> Exercise{
        return currentWorkout.exercises[exerciseIndex]
    }

    func insertUpdatedExercise(exercise: Exercise){
        currentWorkout.exercises[exerciseIndex] = exercise
    }
    
    func goToNextExercise() -> Bool{
        exerciseIndex += 1
        if (exerciseIndex < currentWorkout.exercises.count){
            return true
        }
        return false
    }
    
    func goToPreviousExercise(){
        if (exerciseIndex > 0){
            exerciseIndex -= 1
        }
    }
    
    
}
