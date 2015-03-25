import Foundation

@objc public protocol BookingRepositoryProtocol {
    func reset()->Bool
    
    func get() -> [BookingDao]
    
    func save(bookings: [BookingDao])->Bool
}

public class BookingRepository:NSObject,BookingRepositoryProtocol{
    
    let repository = Repository<BookingDao>(plist: "Bookings")
    
    public func reset()->Bool{
        self.repository.reset()
        return true
    }
    
    public func get() -> [BookingDao]{
        return self.repository.get()
    }
    
    public func save(bookings: [BookingDao])->Bool{
        return self.repository.save(bookings)
    }
}
