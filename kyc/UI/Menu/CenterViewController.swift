import UIKit

@objc
protocol CenterViewControllerDelegate {
  optional func toggleLeftPanel()
  optional func toggleRightPanel()
  optional func collapseSidePanels()
}

class CenterViewController: UIViewController, SidePanelViewControllerDelegate {
  
  var delegate: CenterViewControllerDelegate?

//      func didPressAdd(){
//        
//        if (Manager.sharedInstance.isAuthenticated) {
//            
//            if let placeYourTagViewController = ViewControllersFactory.instantiateControllerWithClass(PlaceYourTagViewController.self) as? PlaceYourTagViewController
//            {
//                var navigation = UINavigationController(rootViewController: placeYourTagViewController)
//                navigation.navigationBarHidden = true
//                self.presentViewController(navigation, animated: true, completion: nil)
//            }
//        }
//        else if(BagManager.sharedInstance.arrayOfAnchors().count == 0){
//            
//            if let defineBagViewController = ViewControllersFactory.instantiateControllerWithClass(DefineBagViewController.self) as? DefineBagViewController
//            {
//                var navigation = UINavigationController(rootViewController: defineBagViewController)
//                navigation.navigationBarHidden = true
//                self.presentViewController(navigation, animated: true, completion: nil)
//            }
//        }
//        else {
//            if let measureBagViewController = ViewControllersFactory.instantiateControllerWithClass(DefineBagPlaceAnchorsViewController.self) as? DefineBagPlaceAnchorsViewController
//            {
//                var navigation = UINavigationController(rootViewController: measureBagViewController)
//                navigation.navigationBarHidden = true
//                self.presentViewController(navigation, animated: true, completion: nil)
//            }
//        }
//      }
    
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
            var viewController: UIViewController? = ViewControllersFactory.instantiateControllerWithClass(typeClass!) as UIViewController?
            
            if (viewController != nil){
                self.navigationController?.presentViewController(viewController!, animated: true, completion: nil)
            }
    }

        delegate?.collapseSidePanels?()
    }
}