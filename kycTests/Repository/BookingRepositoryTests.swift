import XCTest
import kyc

public class BookingRepositoryTests: XCTestCase {
    var target : BookingRepository!
    
    public override func setUp() {
        
        self.target = BookingRepository()
        self.target.reset()
    }
    
    public func test_get_and_save_bookings() {
        let date = NSDate(timeIntervalSince1970: 60000)
        let boatName = "Kayak2"
        let state = 1
        let boatId = 45
        let bookingId = 20
        let time = "06:30"
        let day = "Sunday"
        let tripId = 300
        
        var b = BookingDao(date: date, id: bookingId, boatId: boatId, boatName: boatName, tripId: tripId, state: state, time: time, day: day)
        
        var someBookings:[BookingDao] = [b]
        let savedResult = self.target.save(someBookings)
        XCTAssertTrue(savedResult)
        
        var results = self.target.get()
        XCTAssertTrue(results.count == 1)
    }
    

}
