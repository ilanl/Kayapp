import UIKit

class MainViewController: CenterViewController,UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tblForecastsAndBookings: UITableView!
    
    var forecastCellArray:[ForecastDataCell] = []
    var sectionArray:[ForecastSection]?
    
    let forecastAndBookingMatcher = coreComponents.componentForKey("forecastAndBookingMatcherFactory") as! ForecastAndBookingMatcher
    
    @IBAction func menuTapped(sender: AnyObject) {
        delegate?.toggleLeftPanel?()
    }
    
    override func viewDidLoad() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadData", name: doneLoadDataNotificationKey, object: nil)
    }
    
    func loadData(){
        
        self.sectionArray = self.forecastAndBookingMatcher.getSections()
        self.tblForecastsAndBookings.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.loadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.showLoginIfAnoymous()
    }
    
    //MARK: Table methods
    func numberOfSectionsInTableView(tableView:UITableView)->Int
    {
        let sectionCount = self.sectionArray?.count
        
        if let sectionCount = self.sectionArray?.count
        {
            return sectionCount
        }
        return 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    
        let totalRows = self.sectionArray![section].totalRows
        return totalRows
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 52
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let section:ForecastSection = self.sectionArray![indexPath.section]
        self.forecastCellArray = self.forecastAndBookingMatcher.getForecastsWithMatchingBookings(section.date)
        let data:ForecastDataCell = self.forecastCellArray[indexPath.row]
        
        var forecast:ForecastDao? = data.forecast
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let forecastDayTime = dateFormatter.stringFromDate(data.forecast!.datetime!)
        
        if (data.booking != nil){
            let cell: ForecastWithBookingCell = tableView.dequeueReusableCellWithIdentifier("forecastWithBookingCell", forIndexPath: indexPath) as! ForecastWithBookingCell
            
            cell.forecast = data.forecast!
            
            cell.hourLabel.text = "\(forecastDayTime)"
            cell.tempLabel.text = "\(data.forecast!.temperature!)"
            cell.waterTemp.text = "11C"
            cell.waveHeightLabel.text = "1,21"
            cell.kayakNameLabel.text = "\(data.booking!.boatName!)"
            return cell
        }
        else{
            let cell:ForecastWithNoBookingCell = tableView.dequeueReusableCellWithIdentifier("forecastNoBookingCell", forIndexPath: indexPath) as! ForecastWithNoBookingCell
            cell.hourLabel.text = "\(forecastDayTime)"
            cell.tempLabel.text = "\(data.forecast!.temperature!)"
            cell.waterTempLabel.text = "16C"
            cell.waveHeightLabel.text = "1,21"
            
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
        
        var f = self.forecastCellArray[indexPath.row].forecast!
        
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
        
        let userRepository = coreComponents.componentForKey("userRepositoryFactory") as! UserRepository
        
        let user:UserDao? = userRepository.get()
        
        if user == nil || user!.isAnonymous(){
            var viewController: UIViewController? = ViewControllersFactory.instantiateControllerWithClass(LoginViewController) as! UIViewController?
            
            if (viewController != nil){
                self.navigationController?.presentViewController(viewController!, animated: true, completion: nil)
            }
        }
        
    }
    
}

