import Foundation
import XCTest
import kyc

public class DayPrefsRepositoryTests : XCTestCase {
    
    var target : DayPrefsRepository!
    
    public override func setUp() {
        
        let factory = TyphoonBlockComponentFactory(assemblies: [CoreComponents()])
        self.target = factory.componentForKey("dayPrefsRepositoryFactory") as? DayPrefsRepository
        self.target.reset()
    }
    
    public func test_get_and_save_dayprefs() {
        
        let day:Int = 2
        let time:Int = 3
        let type:Int = 2
        
        var p = DayPrefDao(day: day, time: time, type: type)
        
        var someDayPrefs:[DayPrefDao] = [p]
        let savedResult = self.target.save(someDayPrefs)
        XCTAssertTrue(savedResult)
        
        var results = self.target.get()
        XCTAssertTrue(results.count == 1)
        
        var result:DayPrefDao = results.first!
        XCTAssertEqual(result.day, day,"Incorrect day")
        XCTAssertEqual(result.time, time,"Incorrect time")
        XCTAssertEqual(result.type, type,"Incorrect type")
    }
}


