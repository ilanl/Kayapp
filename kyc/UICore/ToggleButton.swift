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
            }
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

