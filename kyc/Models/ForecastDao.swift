import Foundation

public class ForecastDao: NSObject,NSCoding{

    public var datetime:NSDate?
    public var weather:NSString?
    public var temperature:Int?
    
    public init(date:NSDate?,weather:NSString?,temperature:Int?) {
        self.datetime = date
        self.weather = weather
        self.temperature = temperature
    }
    
    public required init(coder: NSCoder) {
        self.datetime = coder.decodeObjectForKey("date") as? NSDate
        self.weather = coder.decodeObjectForKey("weather") as? NSString
        self.temperature = coder.decodeObjectForKey("temperature") as? Int
        super.init()
    }
    
    public func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.datetime, forKey: "date")
        coder.encodeObject(self.weather, forKey: "weather")
        coder.encodeObject(self.temperature, forKey: "temperature")
    }
    
    var booking: BookingDao?
}
