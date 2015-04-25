import UIKit

class BoatRankToggleButton:ToggleButton{
    var name:String?
    
    var boatPrefsRepository:BoatPrefsRepository?
    
    func updateData() {
        boatPrefsRepository?.saveOne(BoatPrefDao(name: self.name!, order: self.currentValue!))        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        super.addTarget(self, action: "buttonTap:", forControlEvents: UIControlEvents.TouchDown)
    }
    
    func buttonTap(sender: BoatRankToggleButton) {
        
        println("boat rank tapped: \(sender.currentValue)")
        
        if (sender.currentValue == nil)
        {
            return
        }
        
        var current:ToggleButtonSet = sender._arrayOfValues!.filter({ $0.raw == sender.currentValue!}).first!
        var nextOrder = (current.order+1) % sender._arrayOfValues!.count
        var next:ToggleButtonSet = sender._arrayOfValues!.filter({ $0.order == nextOrder}).first!
        sender.currentValue = next.raw
        
        sender.updateData()
    }
}
