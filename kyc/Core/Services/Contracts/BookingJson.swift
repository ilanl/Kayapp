import Foundation

public class BookingJson:NSObject, Serializable{
    public var status:String?
    public var error:String?
    public var arrayOfBookings:[BookingBoatJson]
    
    required public init(dictionary: [NSObject : AnyObject]) {
        
        self.arrayOfBookings = JsonParser.parseArrayToArrayOfType(dictionary["Bookings"] as [AnyObject])
        
        if let _status = dictionary["Status"] as? String{
            self.status = _status
        }
        if let _error = dictionary["Error"] as? String{
            self.error = _error
        }
    }
}

//"Id":56,
//"KayakKey":"70",
//"Type":2,
//"TripKey":"217",
//"UserId":1,
//"State":0,
//"OutingDate":"1428526800",
//"Day":"Thursday",
//"Time":"06:30",
//"KayakName":"\u05e7\u05d9\u05d0\u05e7 14 \u05d8\u05de\u05e4\u05e1\u05d8 165 \u05de\u05e0\u05d2\u05d5"

public class BookingBoatJson:NSObject, Serializable{
    
    public var id:Int?
    public var boatId:String?
    public var boatType:Int?
    public var tripId:String?
    public var tripDate:String?
    public var time:String?
    public var day:String?
    
    required public init(dictionary: [NSObject : AnyObject]) {
        
        if let _id = dictionary["Id"] as? Int{
            self.id = _id
        }
        if let _boatId = dictionary["KayakKey"] as? String{
            self.boatId = _boatId
        }
        if let _tripId = dictionary["TripKey"] as? String{
            self.tripId = _tripId
        }
        if let _boatType = dictionary["Type"] as? Int{
            self.boatType = _boatType
        }
        if let _tripDate = dictionary["OutingDate"] as? String{
            self.tripDate = _tripDate
        }
        if let _tripDay = dictionary["Day"] as? String{
            self.day = _tripDay
        }
        if let _tripTime = dictionary["Time"] as? String{
            self.time = _tripTime
        }
    }
}



