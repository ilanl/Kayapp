import Foundation
import kyc
import XCTest

class ConfigReaderDummy:ConfigReader{

    required init() {
        super.init()
    }
}

public class ConfigReaderTests : XCTestCase {
    
    var target : ConfigReader!
    
    public func test_config_reader() {
        
        target = ConfigReader()
        XCTAssertNotNil(target.getBookingUrl , "Incorrect Config contents")
    }
    
}