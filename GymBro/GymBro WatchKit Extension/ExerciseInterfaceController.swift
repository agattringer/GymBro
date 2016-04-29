//
//  ExerciseInterfaceController.swift
//  GymBro
//
//  Created by Alexander Gattringer on 29/04/16.
//  Copyright © 2016 Alexander Gattringer. All rights reserved.
//

import WatchKit
import Foundation
import HealthKit

class ExerciseInterfaceController: WKInterfaceController, HKWorkoutSessionDelegate {
    @IBOutlet var timer: WKInterfaceTimer!
    @IBOutlet var currentBPM: WKInterfaceLabel!

    var exercise:Exercise!
    var startTime:NSDate!
    var meanBPM:Int = 0
    
    // define the activity type and location
    var workoutSession : HKWorkoutSession?
    let heartRateUnit = HKUnit(fromString: "count/min")
    var anchor = HKQueryAnchor(fromValue: Int(HKAnchoredObjectQueryNoAnchor))
    let healthStore = HKHealthStore()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        exercise = WorkoutController.sharedController.getCurrentExercise()
        timer.start()
        startTime = NSDate()
        startWorkout()
    }
    
    @IBAction func stopWorkout(){
        if let workout = self.workoutSession {
            healthStore.endWorkoutSession(workout)
        }
        
        timer.stop()
        exercise.duration = Int(NSDate().timeIntervalSinceDate(startTime))
        exercise.meanHeartrate = meanBPM
        WorkoutController.sharedController.insertUpdatedExercise(exercise)
        
        pushControllerWithName("After", context: nil)
    }
    
    override func willActivate() {
        super.willActivate()
        
        guard HKHealthStore.isHealthDataAvailable() == true else {
            currentBPM.setText("not available")
            return
        }
        
        guard let quantityType = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate) else {
            displayNotAllowed()
            return
        }
        
        let dataTypes = Set(arrayLiteral: quantityType)
        healthStore.requestAuthorizationToShareTypes(nil, readTypes: dataTypes) { (success, error) -> Void in
            if success == false {
                self.displayNotAllowed()
            }
        }
    }
    
    func displayNotAllowed() {
        currentBPM.setText("not allowed")
    }
    
    func workoutSession(workoutSession: HKWorkoutSession, didChangeToState toState: HKWorkoutSessionState, fromState: HKWorkoutSessionState, date: NSDate) {
        switch toState {
        case .Running:
            workoutDidStart(date)
        case .Ended:
            workoutDidEnd(date)
        default:
            print("Unexpected state \(toState)")
        }
    }
    
    func workoutSession(workoutSession: HKWorkoutSession, didFailWithError error: NSError) {
        // Do nothing for now
        NSLog("Workout error: \(error.userInfo)")
    }
    
    func workoutDidStart(date : NSDate) {
        if let query = createHeartRateStreamingQuery(date) {
            healthStore.executeQuery(query)
        } else {
            currentBPM.setText("cannot start")
        }
    }
    
    func workoutDidEnd(date : NSDate) {
        if let query = createHeartRateStreamingQuery(date) {
            healthStore.stopQuery(query)
            currentBPM.setText("---")
        } else {
            currentBPM.setText("cannot stop")
        }
    }
    
    func startWorkout() {
        self.workoutSession = HKWorkoutSession(activityType: HKWorkoutActivityType.CrossTraining, locationType: HKWorkoutSessionLocationType.Indoor)
        self.workoutSession?.delegate = self
        healthStore.startWorkoutSession(self.workoutSession!)
    }
    
    func createHeartRateStreamingQuery(workoutStartDate: NSDate) -> HKQuery? {
        
        guard let quantityType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate) else { return nil }
        
        let heartRateQuery = HKAnchoredObjectQuery(type: quantityType, predicate: nil, anchor: anchor, limit: Int(HKObjectQueryNoLimit)) { (query, sampleObjects, deletedObjects, newAnchor, error) -> Void in
            guard let newAnchor = newAnchor else {return}
            self.anchor = newAnchor
            self.updateHeartRate(sampleObjects)
        }
        
        heartRateQuery.updateHandler = {(query, samples, deleteObjects, newAnchor, error) -> Void in
            self.anchor = newAnchor!
            self.updateHeartRate(samples)
        }
        return heartRateQuery
    }
    
    func updateHeartRate(samples: [HKSample]?) {
        guard let heartRateSamples = samples as? [HKQuantitySample] else {return}
        
        dispatch_async(dispatch_get_main_queue()) {
            guard let sample = heartRateSamples.first else{return}
            let value = sample.quantity.doubleValueForUnit(self.heartRateUnit)
            self.currentBPM.setText(String(UInt16(value)))
           
            //CALC MEAN BPM HERE
            self.meanBPM = (self.meanBPM + Int(UInt16(value))) / 2
        }
    }
    
}