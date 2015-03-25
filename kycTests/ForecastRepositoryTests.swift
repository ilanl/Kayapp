import Foundation
import XCTest
import kyc

public class ForecastDaoTests : XCTestCase {
    
    var target : ForecastRepository!
    
    public override func setUp() {
        
        //let factory = TyphoonBlockComponentFactory(assemblies: [CoreComponents()])
        self.target = ForecastRepository() //factory.componentForKey("forecastRepository") as? ForecastRepository
        self.target.reset()
    }
    
    public func test_get_and_save_forecasts() {
        let date = NSDate(timeIntervalSince1970: 60000)
        let weather = "WEATHER"
        let temperature = 1
        
        var f = ForecastDao(date: date, weather: weather, temperature: temperature)
        
        var someForecasts:[ForecastDao] = [f]
        let savedResult = self.target.save(someForecasts)
        XCTAssertTrue(savedResult)
        
        var results = self.target.get()
        XCTAssertTrue(results.count == 1)
    }
}

