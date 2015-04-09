import UIKit

class MainViewController: CenterViewController,UITableViewDataSource, UITableViewDelegate {

    var forecastArray:[ForecastDao]?
    var sectionArray:[ForecastSection]?
    let forecastRepository = coreComponents.componentForKey("forecastRepositoryFactory") as ForecastRepository
    
    @IBAction func menuTapped(sender: AnyObject) {
        delegate?.toggleLeftPanel?()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.forecastArray = self.forecastRepository.get()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.showLoginIfAnoymous()
    }
    
    //MARK: Table methods
    func numberOfSectionsInTableView(tableView:UITableView!)->Int
    {
        var forecastAndBookingMatcher = coreComponents.componentForKey("forecastAndBookingMatcherFactory") as ForecastAndBookingMatcher
        
        self.sectionArray = forecastAndBookingMatcher.getSections()
        let sectionCount = self.sectionArray?.count
        
        if let sectionCount = self.sectionArray?.count
        {
            return sectionCount
        }
        return 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    
        let totalRows = self.sectionArray![section].totalRows
        Logger.log("table:section: \(section), count: \(totalRows)")
        return totalRows
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        let forecast = self.forecastArray![indexPath.row] as ForecastDao
        return forecast.booking != nil ? 120 : 60
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let forecast = forecastArray![indexPath.row] as ForecastDao
        
        if (forecast.booking != nil){
            let cell: ForecastWithBookingCell = tableView.dequeueReusableCellWithIdentifier("forecastWithBookingCell", forIndexPath: indexPath) as ForecastWithBookingCell
            
            let tempLabel = cell.tempLabel
            //tempLabel.text = "\(forecast.temp)"
            
            let tempWaterLabel = cell.waterTemp
            //tempWaterLabel.text = "\(forecast.waterTemp)"
            
            let kayakNameLabel = cell.kayakNameLabel
            //kayakNameLabel.text = "\(forecast.booking!.name)"
            return cell
        }
        else{
            let cell:ForecastWithNoBookingCell = tableView.dequeueReusableCellWithIdentifier("forecastNoBookingCell", forIndexPath: indexPath) as ForecastWithNoBookingCell
            
            let waveHeightLabel = cell.waveHeightLabel
            //waveHeightLabel.text = "\(forecast.waveHeight) cm"
            
            return cell
        }
    }
    
    //MARK: Sections on table
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let sectionTuple = self.sectionArray![section]
        return sectionTuple.title
    }
    
    //MARK: Actions on cells
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        
        if (indexPath.row > 3){
            return nil
        }
        
        var tripActions = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Actions" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            
            let shareMenu = UIAlertController(title: nil, message: "Actions", preferredStyle: .ActionSheet)
            
            let cancelBookingAction = UIAlertAction(title: "Cancel Booking", style: UIAlertActionStyle.Default, handler: nil)
            
            let kayakAction = UIAlertAction(title: "Switch to kayak", style: UIAlertActionStyle.Default, handler: nil)
            
            let surfAction = UIAlertAction(title: "Switch to surf", style: UIAlertActionStyle.Default, handler: nil)
            
            let tryBooking = UIAlertAction(title: "Attempt booking", style: UIAlertActionStyle.Default, handler: nil)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
            
            shareMenu.addAction(cancelBookingAction)
//            shareMenu.addAction(kayakAction)
//            shareMenu.addAction(surfAction)
            shareMenu.addAction(tryBooking)
            shareMenu.addAction(cancelAction)
            
            self.presentViewController(shareMenu, animated: true, completion: nil)
        })
        
        return [tripActions]
    }

    
    //MARK: Private methods
    
    private func showLoginIfAnoymous(){
        
        let userRepository = coreComponents.componentForKey("userRepositoryFactory") as UserRepository
        
        let user:UserDao? = userRepository.get()
        
        if user == nil || user!.isAnonymous(){
            var viewController: UIViewController? = ViewControllersFactory.instantiateControllerWithClass(LoginViewController) as UIViewController?
            
            if (viewController != nil){
                self.navigationController?.presentViewController(viewController!, animated: true, completion: nil)
            }
        }
        
    }
    
}

