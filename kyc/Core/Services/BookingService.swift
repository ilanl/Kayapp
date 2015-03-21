import Foundation
import UIKit
import CoreData

class BookingService{
    
    func get(completion: (([Booking]) -> Void)?){
        
        let forecasts = self.loadData()
        
        if let callback = completion?{
            Logger.log("get callback")
            callback(forecasts)
        }
    }
    
    func save(completion:((Bool) -> Void)?){
        
        if let callback = completion?{
            Logger.log("save callback")
            callback(true)
        }
    }
    
    private func loadData() -> [Booking]{
        
        let context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
        
        //Booking
        for i in 1...2{
            
            var f = NSEntityDescription.insertNewObjectForEntityForName("Booking",
                inManagedObjectContext: context!) as Booking
            f.datetime = NSDate(timeIntervalSinceNow: Double(i*3000))
            f.name = "kayak \(i)"
            
            var error : NSError? = nil
            if !context!.save(&error) {
                NSLog("Unresolved error \(error), \(error!.userInfo)")
                abort()
            }
        }
        let managedObjectContext = AppDelegate.instance.managedObjectContext!
        let fetchRequest = NSFetchRequest(entityName: "Booking")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "datetime", ascending: true)]

        // Execute the fetch request, and cast the results to an array of LogItem objects
        if let fetchResults = managedObjectContext.executeFetchRequest(fetchRequest, error: nil) as? [Booking] {
            
            return fetchResults
        }
        return [Booking]()
    }
    
}

