import UIKit

class MainViewController: CenterViewController,UITableViewDataSource, UITableViewDelegate {

    var forecastArray:[Forecast]?
    var sectionArray:[(title:String,date:NSDate,totalRows:Int)] = []
    
    let dateFormatter = NSDateFormatter()
    
    @IBAction func menuTapped(sender: AnyObject) {
        delegate?.toggleLeftPanel?()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let forecastService = ForecastService()
        forecastService.get({ forecasts in
            
                let bookingService = BookingService()
                bookingService.get({ bookings in
                    
                    self.dateFormatter.dateFormat = "dd MMM"
                    
                    for forecast in forecasts{
                        
                        Logger.log("forecast: \(forecast.datetime)")
                        
                        //Add header
                        let strForecastDay = self.dateFormatter.stringFromDate(forecast.datetime)
                        let sectionTuple = (title:"\(strForecastDay)",date:forecast.datetime, totalRows:1)
                        
                        if (self.sectionArray.last?.title != sectionTuple.title){
                            self.sectionArray.append(sectionTuple)
                        }
                        else{
                            var counter:Int = self.sectionArray.last!.totalRows
                            var tuple = self.sectionArray.last!
                            self.sectionArray[self.sectionArray.count-1] = (title:"\(strForecastDay)",date:forecast.datetime, totalRows:++counter)
                            
                        }
                        
                        for booking in bookings{
                            if (self.checkIfForecastMatchBookingTime(forecast,booking:booking) == true){
                                
                                Logger.log("booking: \(booking.datetime)")
                                forecast.booking = booking
                                break
                            }
                        }
                    }
                    
                })
                self.forecastArray = forecasts
            
            })
    }
    
    //MARK: Table methods
    func numberOfSectionsInTableView(tableView:UITableView!)->Int
    {
        let sectionCount = self.sectionArray.count
        Logger.log("table:number of sections: \(sectionCount)")
        return sectionCount
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    
        let totalRows = sectionArray[section].totalRows
        Logger.log("table:section: \(section), count: \(totalRows)")
        return totalRows
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        let forecast = forecastArray![indexPath.row] as Forecast
        return forecast.booking != nil ? 120 : 60
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let forecast = forecastArray![indexPath.row] as Forecast
        
        if (forecast.booking != nil){
            let cell: ForecastWithBookingCell = tableView.dequeueReusableCellWithIdentifier("forecastWithBookingCell", forIndexPath: indexPath) as ForecastWithBookingCell
            
            let tempLabel = cell.tempLabel
            tempLabel.text = "\(forecast.temp)"
            
            let tempWaterLabel = cell.waterTemp
            tempWaterLabel.text = "\(forecast.waterTemp)"
            
            let kayakNameLabel = cell.kayakNameLabel
            kayakNameLabel.text = "\(forecast.booking!.name)"
            return cell
        }
        else{
            let cell:ForecastWithNoBookingCell = tableView.dequeueReusableCellWithIdentifier("forecastNoBookingCell", forIndexPath: indexPath) as ForecastWithNoBookingCell
            
            let waveHeightLabel = cell.waveHeightLabel
            waveHeightLabel.text = "\(forecast.waveHeight) cm"
            
            return cell
        }
    }
    
    //MARK: Sections on table
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let sectionTuple = self.sectionArray[section]
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
    private func checkIfForecastMatchBookingTime(forecast:Forecast,booking:Booking) -> Bool{
        let bookingTime = booking.datetime
        let interval = booking.datetime.minutesFrom(forecast.datetime)
        if (interval == 0){
            return true
        }
        return false
    }
    
    
}

