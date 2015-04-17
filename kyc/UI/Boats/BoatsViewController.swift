import UIKit

class RankingBoatsViewController: UIViewController ,UITableViewDataSource, UITableViewDelegate {
    
    var boatsArray:[BoatDao]?
    let boatRepository = coreComponents.componentForKey("boatsRepositoryFactory") as! BoatsRepository
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBAction func didPressClose(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func boatFilter(boat: BoatDao)-> Bool{
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.boatsArray = self.dataSource()
    }
    
    func dataSource()->[BoatDao]{
        var boatsWithType = [BoatDao]()
        for b in self.boatRepository.get(){
            
            if (self.boatFilter(b)){
                boatsWithType.append(b)
            }
        }
        return boatsWithType
    }
    
    //MARK: Table methods
    func numberOfSectionsInTableView(tableView:UITableView)->Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return self.boatsArray!.count
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 60
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell:BoatRankCell = tableView.dequeueReusableCellWithIdentifier("boatRankCell", forIndexPath: indexPath) as! BoatRankCell
        
        let boatDao = self.boatsArray![indexPath.row]
        let name = boatDao.name!
        cell.lblName.text = name
        cell.btnOrder._arrayOfValues = [(imageName : "plus", raw : 0, order: 0),(imageName : "1", raw : 1, order: 1),(imageName : "2", raw : 2, order: 2),(imageName : "3", raw : 3, order: 3)]
        
        self.setCell(cell,rowIndex: indexPath,name: name)
        
        return cell
    }
    
    
    let boatPrefsRepository = coreComponents.componentForKey("boatPrefsRepositoryFactory") as! BoatPrefsRepository
    
    func setCell(cell: BoatRankCell,rowIndex: NSIndexPath, name: String) {
        
        var boatPrefsArray = self.boatPrefsRepository.get()
        cell.btnOrder!.currentValue = 0
        cell.btnOrder!.name = name
        cell.btnOrder!.boatPrefsRepository = self.boatPrefsRepository
        
        if let boatPref = boatPrefsArray.filter({ $0.name == name }).first{
            cell.btnOrder!.currentValue = boatPref.order
        }
    }
}
