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
            
            var userDao = UserDao(name: "%D7%90%D7%99%D7%9C%D7%9F%20%D7%9C", pwd: "32371")
            userDao.deviceToken = "7851dc5ce47f31105238767b8e45614789bb46542e4b251fb7b685982dbc4e47"
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



