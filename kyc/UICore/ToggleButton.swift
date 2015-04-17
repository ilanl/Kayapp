import UIKit

typealias ToggleButtonSet = (imageName : String, raw : Int, order: Int)

class ToggleButton:UIButton{
    var _arrayOfValues:[ToggleButtonSet]?
    var _currentValue:Int?
    
    var currentValue:Int?{
        get{
            return _currentValue
        }
        set{
            if let current:ToggleButtonSet = _arrayOfValues?.filter({ $0.raw == newValue}).first!{
                self.setImage(UIImage (named: current.imageName), forState: .Normal)
                self._currentValue = current.raw
                println("new value: \(self._currentValue)")
            }
        }
    }
    
    func buttonTap(sender: ToggleButton) {
        
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
    
    func updateData(){
        fatalError("not implemented")
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        super.addTarget(self, action: "buttonTap:", forControlEvents: UIControlEvents.TouchDown)
    }
}

class DayPrefToggleButton:ToggleButton{
    var day: Int?
    var time: Int?
    
    var dayPrefRepository:DayPrefsRepository?
    
    override func updateData() {
        self.dayPrefRepository?.saveOne(DayPrefDao(day: self.day!, time: self.time!, type: self.currentValue!))
        
        println("cell: \(self.currentValue)")
    }
}

