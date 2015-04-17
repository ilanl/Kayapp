import UIKit

class DayPrefToggleButton:ToggleButton{
    var day: Int?
    var time: Int?
    
    var dayPrefRepository:DayPrefsRepository?
    
    func updateData() {
        self.dayPrefRepository?.saveOne(DayPrefDao(day: self.day!, time: self.time!, type: self.currentValue!))
        
        println("cell: \(self.currentValue)")
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        super.addTarget(self, action: "buttonTap:", forControlEvents: UIControlEvents.TouchDown)
    }
    
    func buttonTap(sender: DayPrefToggleButton) {
        
        println("boat pref tapped: \(sender.currentValue)")
        
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
