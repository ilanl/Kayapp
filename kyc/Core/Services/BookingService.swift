import Foundation

@objc public protocol BookingServiceProtocol {
    
    func getBookings(onSuccess successBlock: (([BookingDao]) -> Void)?, onError errorBlock: ((String) -> Void)?)
}

public class BookingService: NSObject, BookingServiceProtocol {
    
    var bookingRepository:BookingRepository?
    var userRepository:UserRepository?
    
    override init() {
        println("init")
    }
    
    init(bookingRepo:BookingRepository,userRepo:UserRepository) {
        self.bookingRepository = bookingRepo
        self.userRepository = userRepo
    }
    
    public func getBookings(onSuccess successBlock: (([BookingDao]) -> Void)?, onError errorBlock: ((String) -> Void)?)
    {
        let url = "http://breezback.com/IKayak/bookings.ashx"
        //{"DeviceToken":"7851dc5ce47f31105238767b8e45614789bb46542e4b251fb7b685982dbc4e47","Action":"0","Password":"32371","UserName":"%D7%90%D7%99%D7%9C%D7%9F%20%D7%9C","Keys":null,"SecurityToken":null}
        
        let userDao = self.userRepository!.get()
        if userDao == nil || userDao!.isAnonymous(){
            fatalError("can not fetch preferences as anonymous")
        }
        
        JsonClient.post(["UserName":userDao!.name, "Password":userDao!.pwd, "Action":"0","DeviceToken":userDao!.deviceToken!], url: url){ (data:NSData) -> Void in
            
            let bookingJson = BookingParser.parseJson(data)
            
            if bookingJson.status?.lowercaseString != "success" {
                errorBlock!("could not fetch bookings")
            }
            var bookingDaos = [BookingDao]()
            for f in bookingJson.arrayOfBookings
            {
                let timeinterval : NSTimeInterval = (f.tripDate! as NSString).doubleValue
                let date:NSDate? = NSDate(timeIntervalSince1970: timeinterval) as NSDate?
                let boatName : String = f.boatName!
                let id : Int = f.id!
                let boatId : Int = (f.boatId! as NSString).integerValue
                let tripId : Int = (f.tripId! as NSString).integerValue
                let day : String = f.day!
                let state: Int = f.state!
                let time : String = f.time!
                let bookingDao = BookingDao(date: date, id: id, boatId: boatId, boatName: boatName, tripId: tripId, state: state, time: time, day: day)
                bookingDaos.append(bookingDao)
            }
            self.bookingRepository!.save(bookingDaos)
            
            successBlock!(bookingDaos)
        }
    }
}