import UIKit

class ViewControllersFactory: NSObject {
    
    private class func getStoryboardNameWithClassName(name : String) ->String?
    {
        let KMainStoryBoardName : String = "Main"
        let KSettingsStoryBoardName : String = "Settings"
        let kBoatsStoryBoardName : String = "Boats"
        let kBookingsStoryBoardName : String = "Bookings"
        let kDaysStoryBoardName : String = "Days"
        
        var storyBoardName : String?
        
        switch name {
            case  NSStringFromClass(SettingsViewController.self):
                storyBoardName = KSettingsStoryBoardName
        
            case NSStringFromClass(DaysViewController.self):
                storyBoardName = kDaysStoryBoardName
            
            case  NSStringFromClass(BoatsViewController.self):
                storyBoardName = kBoatsStoryBoardName
            
            case  NSStringFromClass(BookingsViewController.self):
                storyBoardName = kBookingsStoryBoardName
            
            case  NSStringFromClass(MainViewController.self):
                storyBoardName = KMainStoryBoardName
            
            default:
                storyBoardName = ""
        }
        
        return storyBoardName
    }
    
    class func instantiateControllerWithClass(typeClass : AnyClass ) -> AnyObject?
    {
        var theViewController : AnyObject?
        var controllerName : String? = NSStringFromClass(typeClass)
        
        
        if (controllerName != nil)
        {
            let controllerNameComponents : [String] =  controllerName!.componentsSeparatedByString(".")
            controllerName = controllerNameComponents.last
            if(controllerName != nil)
            {
                var storyBoardName : String? = ViewControllersFactory.getStoryboardNameWithClassName(NSStringFromClass(typeClass))
                if let isStoryBoardName = storyBoardName
                {
                    let storyboard = UIStoryboard(name: isStoryBoardName, bundle: nil);
                    theViewController = storyboard.instantiateViewControllerWithIdentifier(controllerName!)
                    return theViewController
                }
            }
            
        }
        
        return nil
    }
   
}
