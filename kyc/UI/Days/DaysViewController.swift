import UIKit

typealias ToggleButtonSet = (imageName : String, raw : String, order: Int)

class ToggleButton:UIButton{
    var _arrayOfValues:[ToggleButtonSet]?
    var _currentValue:String?
    
    var currentValue:String?{
        get{
            return _currentValue
        }
        set{
            if let current:ToggleButtonSet = _arrayOfValues?.filter({ $0.raw == newValue}).first!{
                self.setImage(UIImage (named: current.imageName), forState: .Normal)
                self._currentValue = current.raw
            }
        }
    }
    
    func buttonTap(sender: ToggleButton) {
        
        if (self.currentValue == nil)
        {
            return
        }
        
        var current:ToggleButtonSet = self._arrayOfValues!.filter({ $0.raw == self.currentValue!}).first!
        var nextOrder = (current.order+1) % self._arrayOfValues!.count
        var next:ToggleButtonSet = self._arrayOfValues!.filter({ $0.order == nextOrder}).first!
        self.currentValue = next.raw
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        super.addTarget(self, action: "buttonTap:", forControlEvents: UIControlEvents.TouchDown)
    }
}

class DayPrefSection{
    var title:String
    
    init(title:String){
        self.title = title
    }
}

class DaysViewController: UIViewController ,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var exitButton: UIButton!
    
    var dayPrefsArray:[DayPrefDao]?
    var sectionArray:[DayPrefSection]?
    let dayPrefsRepository = coreComponents.componentForKey("dayPrefsRepositoryFactory") as! DayPrefsRepository
    
    let allDays = Day.everydays()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dayPrefsArray = self.dayPrefsRepository.get()
    }

    //MARK: Table methods
    func numberOfSectionsInTableView(tableView:UITableView)->Int
    {
        return allDays.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return 3
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 60
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        //let dayPref = self.dayPrefsArray![indexPath.row] as! DayPrefDao
        
        let cell:DayPrefCell = tableView.dequeueReusableCellWithIdentifier("dayPrefCell", forIndexPath: indexPath) as! DayPrefCell
        
        let timeLabel = cell.timeLabel
        switch(indexPath.row){
            case 0:
                timeLabel.text = "Morning"
            case 1:
                timeLabel.text = "Afternoon"
            case 2:
                timeLabel.text = "Late"
            default:
                timeLabel.text = "NA"
        }
        cell.btnKayak._arrayOfValues = [(imageName : "Day-page-chosed-Kayak-button", raw : "1", order: 1),(imageName : "Day-page-unchosed-Kayak-button", raw : "0", order: 0)]
        cell.btnKayak.currentValue = "0"
        
        cell.btnSurfSki._arrayOfValues = [(imageName : "Day-page-chosed-surfski-button", raw : "1", order: 1),(imageName : "Day-page-unchosed-surfski-button", raw : "0", order: 0)]
        cell.btnSurfSki.currentValue = "1"
        return cell
    }
    
    //MARK: Sections on table
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        return allDays[section].name
    }
    
    @IBAction func didPressExit(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
