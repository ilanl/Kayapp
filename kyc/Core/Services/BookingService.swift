import Foundation

@objc public protocol BookingServiceProtocol {
    
    func getBookings(onSuccess successBlock: (([BookingDao]) -> Void)?, onError errorBlock: ((String) -> Void)?)
}

public class BookingService: NSObject, BookingServiceProtocol {
    
    var bookingRepository:BookingRepository
    var userRepository:UserRepository
    
    public init(bookingRepo:BookingRepository,userRepo:UserRepository) {
        self.bookingRepository = bookingRepo
        self.userRepository = userRepo
    }
    
    public func getBookings(onSuccess successBlock: (([BookingDao]) -> Void)?, onError errorBlock: ((String) -> Void)?)
    {
        let url:NSURL = NSURL(string: "http://breezback.com/IKayak/bookings.ashx")!
        //{"DeviceToken":"7851dc5ce47f31105238767b8e45614789bb46542e4b251fb7b685982dbc4e47","Action":"0","Password":"32371","UserName":"%D7%90%D7%99%D7%9C%D7%9F%20%D7%9C","Keys":null,"SecurityToken":null}
        
//        JsonClient.get(url){ (data:NSData) -> Void in
//            
//            let forecasts = BookingParser.parseJson(data, attribute: "Bookings")
//            
//            if forecasts.count == 0{
//                errorBlock!("Could not fetch any forecasts")
//                return
//            }
//            var forecastDaos = [BookingDao]()
//            for f in forecasts
//            {
//                let timeinterval : NSTimeInterval = (f.date as NSString).doubleValue
//                let temperature : Int = (f.tempC as NSString).integerValue
//                let date:NSDate? = NSDate(timeIntervalSince1970: timeinterval) as NSDate?
//                let forecastDao = BookingDao(date: date, weather: f.weather, temperature: temperature)
//                forecastDaos.append(forecastDao)
//            }
//            self.forecastRepository.save(forecastDaos)
//            
//            successBlock!(forecastDaos)
//        }
    }
}