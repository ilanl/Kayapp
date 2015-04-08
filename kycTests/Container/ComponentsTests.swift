import Foundation
import XCTest
import kyc

public class ComponentsTests : XCTestCase {
    
    public func test_singleton_repository() {
        
        let factory = TyphoonBlockComponentFactory(assemblies: [CoreComponents()])
        var target = factory.componentForKey("forecastRepositoryFactory") as? ForecastRepository
        
        target?.save([ForecastDao(date: nil, weather: "some weather", temperature: 10)])
        
        var target2 = factory.componentForKey("forecastRepositoryFactory") as? ForecastRepository
        
        let results = target2?.get()
        XCTAssertTrue(results!.count == 1, "Not singleton")
    }
}
