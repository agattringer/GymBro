//
//  ConnectivityManager.swift
//  GymBro
//
//  Created by Alexander Gattringer on 29/04/16.
//  Copyright © 2016 Alexander Gattringer. All rights reserved.
//

import WatchConnectivity

class ConnectivityManager: NSObject, WCSessionDelegate {
    static let sharedManager = ConnectivityManager()
   
    var session : WCSession!
    
    //This prevents others from using the default '()' initializer for this class.
    private override init() {
        super.init()
        watchSetup()
    }
    
    func watchSetup(){
        if WCSession.isSupported() {
            session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
    }
    
    func sendUpdatedPlans(plans: [WorkoutPlan]){
        let dataDict = WorkoutPlan.plansToDict(plans)
        do {
            try WCSession.defaultSession().updateApplicationContext(dataDict)
        } catch {
            print("Cannot send data to watch: \(error)")
        }
    }
    
    func sendUpdatedSessions(sessions: [WorkoutSession]){
        let dataDict = WorkoutSession.sessionsToDict(sessions)
        do {
            try WCSession.defaultSession().updateApplicationContext(dataDict)
        } catch {
            print("Cannot send data to watch: \(error)")
        }
    }
    
    func session(session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]) {
        var sessions = [WorkoutSession]()
        if let data = applicationContext["sessions"] as? NSData{
            sessions = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! [WorkoutSession]
        }
        
        DataManager.sharedManager.saveSessions(sessions)
        print("WATCH: Data received")

    }
}
