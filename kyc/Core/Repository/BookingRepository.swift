import Foundation

@objc public protocol BookingRepositoryProtocol {
    func reset()->Bool
    
    func get() -> [BookingDao]
    
    func save(bookings: [BookingDao])->Bool
    
    func saveOne(dayPrefOne: BookingDao)->Bool
    
    func deleteOne(dayPref: BookingDao)->Bool
}

public class BookingRepository:NSObject,BookingRepositoryProtocol{
    
    let repository = Repository<BookingDao>(plist: "Bookings")
    
    public func reset()->Bool{
        self.repository.reset()
        return true
    }
    
    func checkPastBooking(right:BookingDao, date:NSDate) -> Bool{
        return right.datetime!.minutesFrom(date) > 0
    }

    public func get() -> [BookingDao]{
        
        return self.repository.get().filter({ self.checkPastBooking($0, date: NSDate()) })
    }
    
    public func save(bookings: [BookingDao])->Bool{
        return self.repository.save(bookings)
    }
    
    public func saveOne(bookingOne: BookingDao)->Bool{
        return self.repository.saveOne(bookingOne)
    }
    
    public func deleteOne(bookingOne: BookingDao)->Bool{
        return self.repository.delete(bookingOne)
    }
}
