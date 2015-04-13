import UIKit

@objc
protocol CenterViewControllerDelegate {
  optional func toggleLeftPanel()
  optional func toggleRightPanel()
  optional func collapseSidePanels()
}

class CenterViewController: UIViewController, SidePanelViewControllerDelegate {
  
  var delegate: CenterViewControllerDelegate?

    
    func menuItemSelected(menuItem: MenuItem) {
        Logger.log("Clicked on menu item: \(menuItem.title)")
        var typeClass:AnyClass?
        switch(menuItem.tag.lowercaseString){
            case "days":
                typeClass = DaysViewController.self
            case "boats":
                typeClass = BoatsTabViewController.self
            case "bookings":
                typeClass = BookingsViewController.self
            case "settings":
                typeClass = SettingsViewController.self
            
        default:
            break;
        }

        if (typeClass != nil){
            var viewController: UIViewController? = ViewControllersFactory.instantiateControllerWithClass(typeClass!) as! UIViewController?
            
            if (viewController != nil){
                self.navigationController?.presentViewController(viewController!, animated: true, completion: nil)
            }
    }

        delegate?.collapseSidePanels?()
    }
}