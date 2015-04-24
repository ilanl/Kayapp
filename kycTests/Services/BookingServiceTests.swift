import Foundation
import XCTest
import kyc

public class BookingServiceTests : XCTestCase {
    
    var target : BookingService!
    
    var bookingRepository = BookingRepositoryDummy()
    var userRepository=UserRepositoryDummy()
    var configReader = ConfigReaderDummy()
    
    public override func setUp() {
        
        self.target = BookingService(bookingRepository: self.bookingRepository, userRepository: self.userRepository, configReader:self.configReader)
    }
    
    public func test_booking_service_live() {
        
        let expectation = expectationWithDescription("expecting data")
        var bookingsDone : Bool = false
        self.target.getBookings(onSuccess: { (bookings) -> Void in
            
            expectation.fulfill()
            
            bookingsDone = true
            
            }, onError: { (message) -> Void in
                //
        })
        
        waitForExpectationsWithTimeout(5.0, handler:nil)
        
        XCTAssertTrue(bookingsDone, "booking is null")
    }
    
    public class UserRepositoryDummy: UserRepository{
        public var inMemoryRepository = UserDao(name:"dd",pwd:"sss")
        
        public override func get() -> UserDao? {
            
            var userDao = UserDao(name: "tester", pwd: "tester")
            userDao.deviceToken = "some-token-test"
            return userDao
        }
    }
    
    public class BookingRepositoryDummy: BookingRepository{
        public var inMemoryRepository: [BookingDao]?
        
        public override func save(bookings: [BookingDao]) -> Bool {
            self.inMemoryRepository = bookings
            println("saving bookings somewhere")
            return true
        }
    }
}



