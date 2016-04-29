//
//  ExtensionDelegate.swift
//  GymBro WatchKit Extension
//
//  Created by Alexander Gattringer on 15/04/16.
//  Copyright © 2016 Alexander Gattringer. All rights reserved.
//

import WatchKit
import WatchConnectivity

class ExtensionDelegate: NSObject, WKExtensionDelegate, WCSessionDelegate {
    
    var session : WCSession!
    
    func applicationDidFinishLaunching() {
        if WCSession.isSupported() {
            session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
    }
    
    func session(session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]) {
        
        var workoutPlans = [WorkoutPlan]()
        if let data = applicationContext["plans"] as? NSData{
            workoutPlans = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! [WorkoutPlan]
        }
        
        DataManager.sharedManager.saveWorkoutPlans(workoutPlans)
        print("WATCH: Data received")
    }

    func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
    }

}
