//
//  ConnectivityManager.swift
//  GymBro
//
//  Created by Alexander Gattringer on 29/04/16.
//  Copyright © 2016 Alexander Gattringer. All rights reserved.
//

import WatchKit
import WatchConnectivity

class ConnectivityManager: NSObject {
    
    static let sharedManager = ConnectivityManager()
    
    //This prevents others from using the default '()' initializer for this class.
    private override init() {
        super.init()
    }
    
    func sendUpdatedContext(sessions: [WorkoutSession]){
        let dataDict = WorkoutSession.sessionsToDict(sessions)
        do {
            try WCSession.defaultSession().updateApplicationContext(dataDict)
        } catch {
            print("Cannot send data to iPhone: \(error)")
        }
    }
}
