import Foundation

public class SettingDao : NSObject,NSCoding{
    
    public private(set) var mode: Int
    public private(set) var reminder: Int?
    
    public init(mode:Int,reminder:Int?) {
        self.mode = mode
        self.reminder = reminder
    }
    
    public required init(coder: NSCoder) {
        self.mode = coder.decodeObjectForKey("mode") as! Int
        self.reminder = coder.decodeObjectForKey("reminder") as! Int?
        super.init()
    }
    
    public func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.mode, forKey: "mode")
        coder.encodeObject(self.reminder, forKey: "reminder")
    }
}
