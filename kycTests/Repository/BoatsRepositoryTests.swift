import XCTest
import kyc

public class BoatsRepositoryTests: XCTestCase {
    var target : BoatsRepository!
    
    public override func setUp() {
        
        self.target = BoatsRepository()
        self.target.reset()
    }
    
    public func test_get_and_save_boats() {
        let name:String = "Kayak2"
        let type = 1
        
        var b = BoatDao(name: name,type: type)
        
        var someBoats:[BoatDao] = [b]
        let savedResult = self.target.save(someBoats)
        XCTAssertTrue(savedResult)
        
        var results = self.target.get()
        XCTAssertTrue(results.count == 1)
        
        var boat:BoatDao = results.first!
        XCTAssertEqual(boat.boatType.rawValue, BoatType.KAYAK.rawValue,"Incorrect boat type")
        XCTAssertEqual(boat.name!, name,"Incorrect boat name")
    }
    
    
}

