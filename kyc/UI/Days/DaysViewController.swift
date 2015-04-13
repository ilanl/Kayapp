import UIKit

class DayPrefSection{
    var title:String
    
    init(title:String){
        self.title = title
    }
}

class DaysViewController: UIViewController ,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var btnSurfski: UIImageView!
    @IBOutlet weak var btnKayakPref: UIImageView!
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
