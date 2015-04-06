import UIKit


let coreComponents = TyphoonBlockComponentFactory(assemblies: [CoreComponents()])
let fireLoadDataNotificationKey = "com.kyc.fireLoadDataNotificationKey"
let doneLoadDataNotificationKey = "com.kyc.doneLoadDataNotificationKey"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    class var instance:AppDelegate{
        get{
            return UIApplication.sharedApplication().delegate as AppDelegate
        }
    }
        
    //MARK: AppDelegate functions
    var window:UIWindow?
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let containerViewController = ContainerViewController()
        window!.rootViewController = containerViewController
        window!.makeKeyAndVisible()
        
        self.loadData()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadData", name: fireLoadDataNotificationKey, object: nil)
        
        return true
    }

    func loadData(){
        
        let forecastService = coreComponents.componentForKey("forecastServiceFactory") as? ForecastService
        
        forecastService?.getWeather(7, onSuccess: { forecasts in
            
            let preferenceService = coreComponents.componentForKey("preferenceServiceFactory") as? PreferenceService
            preferenceService!.getPreferences({ (boats, boatPrefs, dayPrefs, setting) -> Void in
                
                let bookingService = coreComponents.componentForKey("bookingServiceFactory") as? BookingService
                
                bookingService?.getBookings(onSuccess: { bookings in
                    
                    NSNotificationCenter.defaultCenter().postNotificationName(doneLoadDataNotificationKey, object: self)
                    
                }, onError: {error in
                    println(error)
                })
                
            }, onError: { error in
                println(error)
            })
            
        }, onError: { message in
            println(message)
        })
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

