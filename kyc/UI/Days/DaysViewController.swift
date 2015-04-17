import UIKit

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
        
        self.dayPrefsArray = self.dayPrefsRepository.get()
        
        let daySection = indexPath.section + 1
        println("day: \(daySection)")
        
        let cell:DayPrefCell = tableView.dequeueReusableCellWithIdentifier("dayPrefCell", forIndexPath: indexPath) as! DayPrefCell
        
        cell.btnKayak._arrayOfValues = [(imageName : "Day-page-chosed-Kayak-button", raw : 1, order: 1),(imageName : "Day-page-unchosed-Kayak-button", raw : 0, order: 0)]
        
        cell.btnSurfSki._arrayOfValues = [(imageName : "Day-page-chosed-surfski-button", raw : 2, order: 1),(imageName : "Day-page-unchosed-surfski-button", raw : 0, order: 0)]
        
        
        cell.btnKayak.dayPrefRepository = self.dayPrefsRepository
        cell.btnKayak.day = daySection
        cell.btnKayak.time = indexPath.row
        
        cell.btnSurfSki.dayPrefRepository = self.dayPrefsRepository
        cell.btnSurfSki.day = daySection
        cell.btnSurfSki.time = indexPath.row
        
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
        
        if let foundKayakDayPref = self.dayPrefsArray?.filter({ $0.day == daySection && $0.time == indexPath.row && $0.type == 1 }).first{
            cell.btnKayak.currentValue = 1
        }
        else{
            cell.btnKayak.currentValue = 0
        }
        
        if let foundSurfSkiDayPref = self.dayPrefsArray?.filter({ $0.day == daySection && $0.time == indexPath.row && $0.type == 2 }).first{
            cell.btnSurfSki.currentValue = 2
        }
        else {
            cell.btnSurfSki.currentValue = 0
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
