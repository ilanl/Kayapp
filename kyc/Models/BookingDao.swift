import Foundation

public class BookingDao: NSObject,NSCoding{
    
    public var datetime:NSDate?
    public var name:NSString?
    public var state:Int?
    
    public init(date:NSDate?,name:NSString?,state:Int?) {
        self.datetime = date
        self.name = name
        self.state = state
    }
    
    public required init(coder: NSCoder) {
        self.datetime = coder.decodeObjectForKey("date") as? NSDate
        self.name = coder.decodeObjectForKey("name") as? NSString
        self.state = coder.decodeObjectForKey("state") as? Int
        super.init()
    }
    
    public func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.datetime, forKey: "date")
        coder.encodeObject(self.name, forKey: "name")
        coder.encodeObject(self.state, forKey: "state")
    }
}
