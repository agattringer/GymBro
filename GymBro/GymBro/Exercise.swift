//
//  Exercise.swift
//  GymBro
//
//  Created by Alexander Gattringer on 15/04/16.
//  Copyright © 2016 Alexander Gattringer. All rights reserved.
//

import UIKit

enum ExerciseIntensity : String{
    case Low = "Low"    //15 - 20 repetitions planned
    case Medium = "Medium" //8 - 12
    case High = "High"   //5 - 8
}

private struct PropertyKey {
    static let name = "name"
    static let duration = "duration"
    static let heartrate = "heartrate"
    static let weight = "weight"
    static let repetitions = "repetitions"
    static let intensity = "intensity"
}

@objc(Exercise)
class Exercise: NSObject, NSCoding{
    var name:String
    var duration:Int
    var meanHeartrate:Int
    var weight:Int
    var repetitions:Int
    var intensity:ExerciseIntensity
    
    override init(){
        name = ""
        duration = 0
        meanHeartrate = 0
        weight = 0
        repetitions = 0
        intensity = ExerciseIntensity.Low
    }
    
    convenience init(name:String, intensity:ExerciseIntensity) {
        self.init()
        self.name = name
        self.intensity = intensity
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObjectForKey(PropertyKey.name) as! String
        self.duration = aDecoder.decodeIntegerForKey(PropertyKey.duration) as Int
        self.meanHeartrate = aDecoder.decodeIntegerForKey(PropertyKey.heartrate) as Int
        self.weight = aDecoder.decodeIntegerForKey(PropertyKey.weight) as Int
        self.repetitions = aDecoder.decodeIntegerForKey(PropertyKey.repetitions) as Int
        self.intensity = ExerciseIntensity(rawValue:aDecoder.decodeObjectForKey(PropertyKey.intensity) as! String)!
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.name)
        aCoder.encodeInteger(duration, forKey: PropertyKey.duration)
        aCoder.encodeInteger(meanHeartrate, forKey: PropertyKey.heartrate)
        aCoder.encodeInteger(weight, forKey: PropertyKey.weight)
        aCoder.encodeInteger(repetitions, forKey: PropertyKey.repetitions)
        aCoder.encodeObject(intensity.rawValue, forKey: PropertyKey.intensity)
    }
    
}
