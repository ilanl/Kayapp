import Foundation

public class BookingDao: NSObject,NSCoding{
    
    public var datetime:NSDate?
    public var id:Int?
    public var boatId:Int?
    public var boatName:String?
    public var tripId:Int?
    public var state:Int?
    public var time:String?
    public var day:String?
    
    public init(date:NSDate?,id:Int?,boatId:Int?, boatName:String?,tripId:Int?,state:Int?,time:String?,day:String?) {
        self.datetime = date
        self.id = id
        self.boatId = boatId
        self.boatName = boatName
        self.tripId = tripId
        self.time = time
        self.state = state
        self.day = day
    }
    
    public required init(coder: NSCoder) {
        self.datetime = coder.decodeObjectForKey("date") as? NSDate
        self.id = coder.decodeObjectForKey("id") as? Int
        self.boatId = coder.decodeObjectForKey("boatId") as? Int
        self.boatName = coder.decodeObjectForKey("boatName") as? String
        self.tripId = coder.decodeObjectForKey("tripId") as? Int
        self.state = coder.decodeObjectForKey("state") as? Int
        self.day = coder.decodeObjectForKey("day") as? String
        self.time = coder.decodeObjectForKey("time") as? String
        super.init()
    }
    
    public func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.datetime, forKey: "date")
        coder.encodeObject(self.id, forKey: "id")
        coder.encodeObject(self.boatId, forKey: "boatId")
        coder.encodeObject(self.boatName, forKey: "boatName")
        coder.encodeObject(self.tripId, forKey: "tripId")
        coder.encodeObject(self.state, forKey: "state")
        coder.encodeObject(self.day, forKey: "day")
        coder.encodeObject(self.time, forKey: "time")
    }
}

public func ==(lhs: BookingDao, rhs: BookingDao) -> Bool {
    return lhs.time == rhs.time && lhs.boatId == rhs.boatId && lhs.datetime == rhs.datetime
}
