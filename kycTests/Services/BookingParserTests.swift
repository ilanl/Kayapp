import Foundation
import XCTest
import kyc

public class BookingParserTests : XCTestCase {
    
    public func test_parse_bookings_json() {
        
        var jsonData = JsonParser.readJson(NSBundle(forClass:BookingParserTests.self),fileName:"bookingData")
        
        XCTAssertNotNil(jsonData, "Incorrect Json contents")
        var bookingJson:BookingJson = BookingParser.parseJson(jsonData)
        XCTAssertNotNil(bookingJson, "Incorrect Json Array")
        
        XCTAssertNotNil(bookingJson.arrayOfBookings[0].boatId)
        XCTAssertNotNil(bookingJson.arrayOfBookings[0].boatType)
        XCTAssertNotNil(bookingJson.arrayOfBookings[0].tripDate)
    }
}
