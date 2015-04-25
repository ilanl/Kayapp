import Foundation

public class ForecastDao: NSObject,NSCoding,NSCopying{

    public var datetime:NSDate?
    public var weather:NSString?
    public var temperature:Int?
    
    public func copyWithZone(zone: NSZone) -> AnyObject{
        return ForecastDao(date: self.datetime, weather: self.weather, temperature: self.temperature)
    }
    
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
    
    public func attachBooking(booking:BookingDao){
        self.booking = booking
    }
    
    public func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.datetime, forKey: "date")
        coder.encodeObject(self.weather, forKey: "weather")
        coder.encodeObject(self.temperature, forKey: "temperature")
    }
    
    public private (set) var booking: BookingDao?
}
