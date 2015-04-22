import UIKit

class SettingsViewController: UIViewController ,UITableViewDataSource, UITableViewDelegate{

    let settingRepository = coreComponents.componentForKey("settingRepositoryFactory") as! SettingRepository

    @IBAction func didPressExit(sender: UIButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBOutlet weak var exitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Table methods
    func numberOfSectionsInTableView(tableView:UITableView)->Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return 2
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 60
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        var cell:UITableViewCell!
        
        if (indexPath.row == 0){
            
            println("automatic booking: \(0)")
            
            cell = tableView.dequeueReusableCellWithIdentifier("automaticBookingSettingCell", forIndexPath: indexPath) as! AutomaticBookingCell
            
            (cell as! AutomaticBookingCell).settingRepository = self.settingRepository
            
            (cell as! AutomaticBookingCell).updateUI()
        }
        
        else if (indexPath.row == 1){
            
            println("footer")
            
            cell = tableView.dequeueReusableCellWithIdentifier("automaticBookingFooterCell", forIndexPath: indexPath) as! AutomaticBookingFooterCell
        }
        
        return cell
    }
    
}
