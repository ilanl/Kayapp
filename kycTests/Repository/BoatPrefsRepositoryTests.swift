import Foundation
import XCTest
import kyc

public class BoatPrefsRepositoryTests : XCTestCase {
    
    var target : BoatPrefsRepository!
    
    public override func setUp() {
        
        self.target = BoatPrefsRepository()
        self.target.reset()
    }
    
    public func test_get_and_save_dayprefs() {
        
        let name:String = "kayak name"
        let order:Int = 3
        
        var b = BoatPrefDao(name:name, order: order)
        
        var someBoatPrefs:[BoatPrefDao] = [b]
        let savedResult = self.target.save(someBoatPrefs)
        XCTAssertTrue(savedResult)
        
        var results = self.target.get()
        XCTAssertTrue(results.count == 1)
        
        var result:BoatPrefDao = results.first!
        XCTAssertEqual(result.name, name,"Incorrect name")
        XCTAssertEqual(result.order, order,"Incorrect order")
    }
}


