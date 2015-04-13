import Foundation

public class DayPrefDao : NSObject,NSCoding{

    public private(set) var day: Int
    public private(set) var time: Int
    public private(set) var type: Int
    
    public init(day:Int,time:Int,type:Int) {
        self.day = day
        self.time = time
        self.type = type
    }
    
    public required init(coder: NSCoder) {
        self.day = coder.decodeObjectForKey("day") as! Int
        self.time = coder.decodeObjectForKey("time") as! Int
        self.type = coder.decodeObjectForKey("type")as! Int
        super.init()
    }
    
    public func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.day, forKey: "day")
        coder.encodeObject(self.time, forKey: "time")
        coder.encodeObject(self.type, forKey: "type")
    }
}
