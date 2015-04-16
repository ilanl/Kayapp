import Foundation

public class DayPrefDao : NSObject,NSCoding,Equatable{

    public var day: Int
    public var time: Int
    public var type: Int
    
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

public func ==(lhs: DayPrefDao, rhs: DayPrefDao) -> Bool{
    return lhs.time == rhs.time && lhs.day == rhs.day && lhs.type == rhs.type
}
