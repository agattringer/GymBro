//
//  WorkoutPlan.swift
//  GymBro
//
//  Created by Alexander Gattringer on 15/04/16.
//  Copyright © 2016 Alexander Gattringer. All rights reserved.
//

import UIKit

private struct PropertyKey {
    static let name = "name"
    static let exercises = "exercises"
}

class WorkoutPlan: NSObject, NSCoding{
    
    var name:String
    var exercises:[Exercise]
    
    override init(){
        name = ""
        exercises = [Exercise]()
    }
    
    convenience init(name:String, exercises: [Exercise]){
        self.init()
        self.name = name
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObjectForKey(PropertyKey.name) as! String
        self.exercises = aDecoder.decodeObjectForKey(PropertyKey.exercises) as! [Exercise]
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.name)
        aCoder.encodeObject(exercises, forKey: PropertyKey.exercises)
    }
}
