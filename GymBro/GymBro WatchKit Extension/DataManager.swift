

import UIKit
import WatchKit

class DataManager: NSObject {
    //singleton
    static let sharedManager = DataManager()
    
    var documentsDirectory:NSURL!
    var workoutPlansURL:NSURL!
    var savedSessionsURL:NSURL!
    
    //This prevents others from using the default '()' initializer for this class.
    private override init() {
        documentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
        workoutPlansURL = documentsDirectory.URLByAppendingPathComponent("workoutPlans")
        savedSessionsURL = documentsDirectory.URLByAppendingPathComponent("savedSessions")
    }
    
    func saveSession(session: WorkoutSession){
        var sessions = [WorkoutSession]()
        
        if let loaded = loadSessions(){
            sessions.appendContentsOf(loaded)
        }
        sessions.append(session)
        NSKeyedArchiver.archiveRootObject(sessions, toFile: savedSessionsURL.path!)
        
        ConnectivityManager.sharedManager.sendUpdatedContext(sessions)
    }
    
    func loadSessions() -> [WorkoutSession]?{
        return NSKeyedUnarchiver.unarchiveObjectWithFile(savedSessionsURL.path!) as? [WorkoutSession]
    }
    
    func saveWorkoutPlans(plans: [WorkoutPlan]){
        NSKeyedArchiver.archiveRootObject(plans, toFile: workoutPlansURL.path!)
    }
    
    func loadWorkoutPlanPickerItems() -> [WKPickerItem]{
        
        var pickerItems = [WKPickerItem]()
        
        if let plans = NSKeyedUnarchiver.unarchiveObjectWithFile(workoutPlansURL.path!) as? [WorkoutPlan]{
            for plan in plans {
                let item = WKPickerItem()
                item.title = plan.name
                item.caption = "\(plan.exercises.count) exercise/s"
                pickerItems.append(item)
            }
        }
        
        return pickerItems
    }
    
    func loadWorkoutPlans() -> [WorkoutPlan]?{
        return NSKeyedUnarchiver.unarchiveObjectWithFile(workoutPlansURL.path!) as? [WorkoutPlan]
    }
}
