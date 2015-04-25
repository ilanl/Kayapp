import Foundation

public class ForecastDao: NSObject,NSCoding,DebugPrintable{

    public var datetime:NSDate?
    public var weather:NSString?
    public var temperature:Int?
    public var booking: BookingDao?
    
    public init(date:NSDate?,weather:NSString?,temperature:Int?) {
        self.datetime = date
        self.weather = weather
        self.temperature = temperature
    }
    
    public required init(coder: NSCoder) {
        super.init()
        self.datetime = coder.decodeObjectForKey("date") as? NSDate
        self.weather = coder.decodeObjectForKey("weather") as? NSString
        self.temperature = coder.decodeObjectForKey("temperature") as? Int
        self.booking = coder.decodeObjectForKey("booking") as? BookingDao
    }
    
    public func attachBooking(booking:BookingDao){
        self.booking = booking
    }
    
    public override var debugDescription: String {
        get{
            return "booking: \(self.booking?.boatName)"
        }
    }
    
    public func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.datetime, forKey: "date")
        coder.encodeObject(self.weather, forKey: "weather")
        coder.encodeObject(self.temperature, forKey: "temperature")
        coder.encodeObject(self.booking,forKey: "booking")
    }
}
