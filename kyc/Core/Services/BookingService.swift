import Foundation

@objc public protocol BookingServiceProtocol {
    
    func getBookings(onSuccess successBlock: (([BookingDao]?) -> Void)?, onError errorBlock: ((String) -> Void)?)
}

public class BookingService: NSObject,BookingServiceProtocol {
    
    var bookingRepository:BookingRepository?
    var userRepository:UserRepository?
    var configReader:ConfigReader?
    
    public init(bookingRepository:BookingRepository,userRepository:UserRepository,configReader:ConfigReader) {
        self.bookingRepository = bookingRepository
        self.userRepository = userRepository
        self.configReader = configReader
    }
    
    public func getBookings(onSuccess successBlock: (([BookingDao]?) -> Void)?, onError errorBlock: ((String) -> Void)?)
    {
        let url = configReader!.getBookingUrl
        
        let userDao = self.userRepository!.get()
        if userDao == nil || userDao!.isAnonymous(){
            errorBlock!("can not fetch bookings as! anonymous")
            return
        }
        
        if (userDao == nil || userDao?.deviceToken == nil){
            errorBlock!("bookings - no user credentials")
            return
        }
        
        JsonClient.post(["UserName":userDao!.name, "Password":userDao!.pwd, "Action":"0","DeviceToken":userDao!.deviceToken!], url: url){ (data:NSData) -> Void in            
            
            let bookingJson = BookingParser.parseJson(data)
            let dateFormatterDMY = NSDateFormatter()
            dateFormatterDMY.dateFormat = "dd/MM/yy"
            
            if bookingJson.status?.lowercaseString != "success" {
                errorBlock!("could not fetch bookings")
            }
            var bookingDaos :[BookingDao]?
            for f in bookingJson.arrayOfBookings
            {
                if (bookingDaos == nil){
                    bookingDaos = [BookingDao]()
                }
                
                let timeinterval : NSTimeInterval = (f.tripDate! as NSString).doubleValue
                let dateBiased:NSDate? = NSDate(timeIntervalSince1970: timeinterval) as NSDate?
                let time : String = f.time!
                
                let dateStringAsDMY = dateFormatterDMY.stringFromDate(dateBiased!)
                var dateStringAsDMYHM = "\(dateStringAsDMY) \(time)"
                
                var dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "dd/MM/yy HH:mm"
                dateFormatter.timeZone = NSTimeZone(name: "ASIA - Israel (UTC + 2)")
                dateFormatter.locale = NSLocale(localeIdentifier: "Europe/Athens")
                let date = dateFormatter.dateFromString(dateStringAsDMYHM)

                if (date == nil){
                    fatalError("date is nil")
                }
                
                let boatName : String = f.boatName!
                let id : Int = f.id!
                let boatId : Int = (f.boatId! as NSString).integerValue
                let tripId : Int = (f.tripId! as NSString).integerValue
                let day : String = f.day!
                let state: Int = f.state!
                let bookingDao = BookingDao(date: date!, id: id, boatId: boatId, boatName: boatName, tripId: tripId, state: state, time: time, day: day)
                
                bookingDaos!.append(bookingDao)
            }
            
            if (bookingDaos != nil){
                self.bookingRepository!.save(bookingDaos!)
            }
            
            successBlock!(bookingDaos)
        }
    }
}