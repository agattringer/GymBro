//
//  WorkoutSession.swift
//  GymBro
//
//  Created by Alexander Gattringer on 15/04/16.
//  Copyright © 2016 Alexander Gattringer. All rights reserved.
//

import UIKit

private struct PropertyKey {
    static let date = "date"
    static let usedPlan = "plan"
}

class WorkoutSession: NSObject, NSCoding {

    var date:NSDate
    var usedPlan:WorkoutPlan
    
    override init(){
        date = NSDate()
        usedPlan = WorkoutPlan()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.date = aDecoder.decodeObjectForKey(PropertyKey.date) as! NSDate
        self.usedPlan = aDecoder.decodeObjectForKey(PropertyKey.usedPlan) as! WorkoutPlan
    }

    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(date, forKey: PropertyKey.date)
        aCoder.encodeObject(usedPlan, forKey: PropertyKey.usedPlan)
    }
}

