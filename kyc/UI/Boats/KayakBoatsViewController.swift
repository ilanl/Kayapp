import UIKit

class KayakBoatsViewController: RankingBoatsViewController {

    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBAction func didPressClose(sender: UIButton) {
        super.didPressCloseButton(sender)
    }
    
    let boatPrefsRepository = coreComponents.componentForKey("boatPrefsRepositoryFactory") as! BoatPrefsRepository
    
    override func boatFilter(boat: BoatDao)-> Bool{
        return boat.type == 2
    }
    
    override func setCell(cell: BoatRankCell,rowIndex: NSIndexPath, name: String) {
        
        var boatPrefsArray = self.boatPrefsRepository.get()
        cell.btnOrder!.currentValue = 0
        cell.btnOrder!.name = name
        cell.btnOrder!.boatPrefsRepository = self.boatPrefsRepository
        
        if let boatPref = boatPrefsArray.filter({ $0.name == name }).first{
            cell.btnOrder!.currentValue = boatPref.order
        }
    }
}
