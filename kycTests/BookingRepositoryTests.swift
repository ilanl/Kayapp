import XCTest
import kyc

public class BookingRepositoryTests: XCTestCase {
    var target : BookingRepository!
    
    public override func setUp() {
        
        let factory = TyphoonBlockComponentFactory(assemblies: [CoreComponents()])
        self.target = factory.componentForKey("bookingRepositoryFactory") as? BookingRepository
        self.target.reset()
    }
    
    public func test_get_and_save_bookings() {
        let date = NSDate(timeIntervalSince1970: 60000)
        let name = "Kayak2"
        let state = 1
        
        var b = BookingDao(date: date, name: name, state: state)
        
        var someBookings:[BookingDao] = [b]
        let savedResult = self.target.save(someBookings)
        XCTAssertTrue(savedResult)
        
        var results = self.target.get()
        XCTAssertTrue(results.count == 1)
    }
    

}
