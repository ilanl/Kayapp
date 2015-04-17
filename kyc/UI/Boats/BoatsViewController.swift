import UIKit

class RankingBoatsViewController: UIViewController ,UITableViewDataSource, UITableViewDelegate {
    
    var boatPrefsArray:[BoatPrefDao]?
    let boatPrefsRepository = coreComponents.componentForKey("boatPrefsRepositoryFactory") as! BoatPrefsRepository
    
    let allDays = Day.everydays()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.boatPrefsArray = self.boatPrefsRepository.get()
    }
    
    //MARK: Table methods
    func numberOfSectionsInTableView(tableView:UITableView)->Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return 20
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 60
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
//        let daySection = indexPath.section + 1
//        println("day: \(daySection)")
//        
        let cell:BoatRankCell = tableView.dequeueReusableCellWithIdentifier("boatRankCell", forIndexPath: indexPath) as! BoatRankCell
//
//        cell.btnKayak._arrayOfValues = [(imageName : "Day-page-chosed-Kayak-button", raw : 1, order: 1),(imageName : "Day-page-unchosed-Kayak-button", raw : 0, order: 0)]
//        
//        cell.btnKayak.dayPrefRepository = self.dayPrefsRepository
//        cell.btnKayak.day = daySection
//        cell.btnKayak.time = indexPath.row
//        
//        cell.btnSurfSki.dayPrefRepository = self.dayPrefsRepository
//        cell.btnSurfSki.day = daySection
//        cell.btnSurfSki.time = indexPath.row
//        
//        let timeLabel = cell.timeLabel
//        switch(indexPath.row){
//        case 0:
//            timeLabel.text = "Morning"
//        case 1:
//            timeLabel.text = "Afternoon"
//        case 2:
//            timeLabel.text = "Late"
//        default:
//            timeLabel.text = "NA"
//        }
//        
//        if let foundBoatPref = self.boatPrefsArray?.filter({ $0.type == 1 && $0.order > 0 && $0.name }).first{
//            cell.btnKayak.currentValue = 1
//        }
//        else{
//            cell.btnKayak.currentValue = 0
//        }
//        
        return cell
    }
    
    func didPressCloseButton(button:UIButton){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
