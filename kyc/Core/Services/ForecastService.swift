import Foundation
import UIKit
import CoreData

class ForecastService{

    func get(completion: (([Forecast]) -> Void)?){
        
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
    
    private func loadData() -> [Forecast]{
        
        let context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
        
        //Forecasts
        for i in 1...100{
            
            var f = NSEntityDescription.insertNewObjectForEntityForName("Forecast",
                inManagedObjectContext: context!) as Forecast
            f.waterTemp = NSNumber(unsignedInt: arc4random_uniform(30))
            f.waveHeight = NSNumber(unsignedInt: arc4random_uniform(3))
            f.weather = NSNumber(unsignedInt: arc4random_uniform(20))
            f.datetime = NSDate(timeIntervalSinceNow: Double(i*1000))
            f.temp = NSNumber(unsignedInt: arc4random_uniform(30))
            
            var error : NSError? = nil
            if !context!.save(&error) {
                NSLog("Unresolved error \(error), \(error!.userInfo)")
                abort()
            }
        }
        let managedObjectContext = AppDelegate.instance.managedObjectContext!
        let fetchRequest = NSFetchRequest(entityName: "Forecast")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "datetime", ascending: true)]
        
        // Execute the fetch request, and cast the results to an array of objects
        if let fetchResults = managedObjectContext.executeFetchRequest(fetchRequest, error: nil) as? [Forecast] {
            
            return fetchResults
        }
        return [Forecast]()
    }

}

